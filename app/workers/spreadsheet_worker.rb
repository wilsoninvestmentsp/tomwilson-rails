class SpreadsheetWorker

	require 'csv'

	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform user_id

		@job = Job.new user_id: user_id,name: 'master_spreadsheet_sync',status: :started

		begin
			
			# url = URI.escape "https://sheets.googleapis.com/v4/spreadsheets/1lHiaNk_YJXQ7YeJdj36EWYxOaynsL_8RiyXQNA6KQPg/values/A:GH?key=#{GOOGLE_SERVER_KEY}"
			url = URI.escape "https://sheets.googleapis.com/v4/spreadsheets/#{MASTER_SPREADSHEET_ID}/values/A:GH?key=#{GOOGLE_SERVER_KEY}"
			uri = URI.parse url

			puts "++++"*10
			puts "++++"*10
			puts url
			puts "++++"*10
			puts "++++"*10

			http = Net::HTTP.new uri.host,uri.port
			http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			http.use_ssl = true

			request = Net::HTTP::Get.new(uri.path+"?"+uri.query)
			request.content_type = 'application/json'

			response = http.request request

			code = response.code.to_f.round
			body = response.body

			if code != 200
				puts "Error: #{code}"
				puts body
				@job.status = code.to_s
				@job.save!
				return
			end

			data = JSON.parse(body.force_encoding('UTF-8'))
			values = data['values']

			csv_data = CSV.generate do |csv|

				values.each_with_index do |row,i|

					new_row = row

					new_row = row.map { |item| item.strip } if i == 0

					csv << new_row

				end

			end

			def normal val

				return nil if !val.present?
				return val.strip

			end

			# File.write 'files/test.csv',csv_data
			i = 0
			properties = []
			csv = CSV.parse csv_data,headers: true do |row|

				i+=1

				property = {}
				property[:building_type] = row['building_type-x'].parameterize.underscore if row['building_type-x'].present?
				
				new_address = row['address-x']
				if new_address.present?

					new_address.strip!
					number = new_address.match /[-\d\/]+/i
					new_address.gsub! /[-\d]+/i,''
					new_address = "#{number} #{new_address}"
					new_address.gsub! /\(.+\)/i,''
					new_address.strip!
					new_address.chomp! '/'
					new_address.strip!

				end

				property[:address] = new_address
				property[:city] = normal(row['city-x'])
				property[:state] = :tx
				property[:year_built] = normal(row['year_built-x'])
				property[:zip] = normal(row['zip-x'])
				property[:square_ft] = normal(row['square_ft-x'])
				property[:offer_price] = normal(row['offer_price-x'])
				property[:offer_price] = property[:offer_price].to_f*1000 if property[:offer_price].present?
				property[:rent] = normal(row['rent-x'])
				property[:status] = row['status-x'].strip.parameterize.underscore if row['status-x'].present?
				property[:leased] = 'yes' if row['leased-x'].present? && ['y','yes'].include?(row['leased-x'].strip.downcase)
				property[:bedrooms] = normal(row['bedrooms-x'])
				property[:bathrooms] = normal(row['bathrooms-x'])
				property[:garages] = normal(row['garages-x'])
				# property[:carports] = normal(row['carports-x'])
				property[:cash_flow] = normal(row['cash_flow-x'])
				property[:lot_size] = normal(row['lot_size-x'])
				property[:school_district] = normal(row['school_district-x'])
				property[:active] = ['y','yes'].include?(row['active-x'].strip.downcase) if row['active-x'].present?

				properties << property if row['city-x'].present? && i >= 17

			end

			log_attempts = 0
			log_new_success = 0
			log_old_success = 0
			properties.each do |property|

				@current = Property.where(address: property[:address],city: property[:city],zip: property[:zip]).first

				log_attempts += 1

				if @current

					if @current.update(property)

						log_old_success += 1

						puts "UPDATE OLD(#{@current.id}): #{@current.address}"

					else

						puts "ERROR OLD(#{@current.id}): #{@current.address} #{@current.errors.to_a.to_s}"

					end

				else

					@new = Property.new property

					if @new.save

						log_new_success += 1

						puts "CREATE NEW(#{@new.id}): #{@new.address}"

					else

						puts "ERROR NEW: #{@new.address} #{@new.errors.to_a.to_s}"

					end

				end

			end

			puts "OLD: #{log_old_success}:#{log_new_success} #{log_old_success+log_new_success} / #{log_attempts}"

			@job.status = :completed
			@job.save!

		rescue
			
			@job.status = :rescued
			@job.save!

		end

	end

end