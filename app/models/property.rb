class Property < ActiveRecord::Base

	has_many :images
	has_many :links

	mount_uploader :image,PropertyUploader

	extend FriendlyId
	friendly_id :slug_candidates, use: :slugged

	validates_presence_of :building_type, :address, :city, :state, :zip
  validates_uniqueness_of :address, scope: [:city, :state, :zip]
	
  after_create :create_links

  scope :by_featured, -> (featured_arr) { where(:featured => featured_arr) }
	scope :active, -> { where(:active => true) }
	scope :not_sold, -> { where.not(:status => 'sold') }
	scope :by_status, -> (status) { where(:status => status) }

  validates :property_management_fee, :mortgage_payment, :hoa_fee,
  :property_tax, :hazard_insurance, numericality: { greater_than_or_equal_to: 0 }

  def create_links
    links = [{title: 'Community Overview'}, {title: 'Appraisal Tax Record'}, {title: 'Parcel Map'}, {title: 'Tax Statement'}, {title: 'School District'}, {title: 'Accident'}]
    links.each do |l|
      Link.create(property_id: id, title: l[:title])
    end
  end

	def slug_candidates
	  [ :title, [:address, :city, :state] ]
	end

	def raw_title
		self.title.present? ? self.title : raw_address
	end

	def raw_address
		"#{self.address.cap_each}, #{self.city.cap_each}, #{self.state.upcase}, #{self.zip}" if self.address.present? && self.city.present? && self.state.present?
	end

	def raw_map_address
   (self.address.present? && self.city.present? && self.state.present?) ? "#{self.address.cap_each}, #{self.city.cap_each}, #{self.state.upcase}, #{self.zip}" : self.title
  end

	def raw_offer_price
		helper.number_with_precision(self.offer_price,precision: 0,delimiter: ',')
	end
	def raw_cash_flow
		helper.number_with_precision(self.cash_flow,precision: 0,delimiter: ',')
	end
	def raw_rent
		helper.number_with_precision(self.rent,precision: 0,delimiter: ',')
	end
	def raw_status
		if self.status.present?
			self.status.humanize.cap_each
		else
			return nil
		end
	end
	def raw_school_district
		if self.school_district.present?
			self.school_district.humanize.cap_each
		else
			nil
		end
	end
	def raw_building_type
		self.building_type.humanize.cap_each
	end

	def chart

		return nil if !self.rent.present? || self.rent == 0

		final = []

		value = helper.number_with_precision(self.property_management_fee.to_f / 12.to_f,precision: 0)
		final << {
			title: 'Property Management',
			value: value,
			raw_value: helper.number_with_precision(value,precision: 0,delimiter: ',')
		} if self.property_management_fee.present?

		value = helper.number_with_precision(self.mortgage_payment,precision: 0)
		final << {
			title: 'Loan Payment',
			value: value,
			raw_value: helper.number_with_precision(value,precision: 0,delimiter: ',')
		} if self.mortgage_payment.present? && self.mortgage_payment > 0

		value = helper.number_with_precision(self.hoa_fee.to_f / 12.to_f,precision: 0)
		final << {
			title: 'HOA',
			value: value,
			raw_value: helper.number_with_precision(value,precision: 0,delimiter: ',')
		} if self.hoa_fee.present? && self.hoa_fee > 0

		value = helper.number_with_precision(self.property_tax.to_f / 12.to_f,precision: 0)
		final << {
			title: 'Property Tax',
			value: value,
			raw_value: helper.number_with_precision(value,precision: 0,delimiter: ',')
		} if self.property_tax.present? && self.property_tax > 0

		value = helper.number_with_precision(self.hazard_insurance.to_f / 12.to_f,precision: 0)
		final << {
			title: 'Insurance',
			value: value,
			raw_value: helper.number_with_precision(value,precision: 0,delimiter: ',')
		} if self.hazard_insurance.present? && self.hazard_insurance > 0

		if final.count > 0 && self.rent.present?

			total = 0.0

			final.each do |val|

				total += val[:value].to_f

			end

			value = helper.number_with_precision(self.rent.to_f - total.to_f,precision: 0)
			value = self.cash_flow.round.to_i if self.cash_flow.present?
			final << {
				title: 'Cash Flow',
				value: value,
				raw_value: helper.number_with_precision(value,precision: 0,delimiter: ',')
			}

			return {
				rent: self.raw_rent,
				chart: final
			}

		else

			return nil

		end

	end

	# Begin import :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
	def self.import file

		accepted_fields = [
			'address',
			'city',
			'zip',
			'building_type',
			'school_district',
			'status',
			'active',
			'year_built',
			'square_ft',
			'lot_size',
			'bedrooms',
			'bathrooms',
			'garages',
			'offer_price',
			'cash_flow',
			'rent',
			'leased',
			'property_management_fee',
			'mortgage_payment',
			'hoa_fee',
			'property_tax',
			'hazard_insurance'
		]

		errors = []
		e = []

		CSV.foreach(file.path, headers: true).with_index do |row, i|
			if row['address'].present?
  			newRow = row.clone
  			errors << row.headers.unshift('error') if i.zero?
  			errors << row.fields.unshift('') if row['ignore'].eql?('header')

  			data = row.clone.to_hash.slice(
  				'id',
  				'address',
  				'city',
  				'state',
  				'zip',
  				'building_type',
  				'school_district',
  				'status',
  				'active',
  				'year_built',
  				'square_ft',
  				'lot_size',
  				'bedrooms',
  				'bathrooms',
  				'garages',
  				'offer_price',
  				'cash_flow',
  				'rent',
  				'leased',
  				'property_management_fee',
  				'mortgage_payment',
  				'hoa_fee',
  				'property_tax',
  				'hazard_insurance'
  			)

			  new_address = data['address'].clone
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

    		data['address'] = new_address
    		data['building_type'] = data['building_type'].parameterize.underscore if data['building_type'].present?
    		data['status'] = data['status'].parameterize.underscore if data['status'].present?
    		data['active'] = ['y','yes'].include?(data['active'].strip.downcase) if data['active'].present?
    		data['offer_price'] = data['offer_price'].to_f * 1000 if data['offer_price'].present?
    		data['leased'] = data['leased'].parameterize.underscore if data['leased'].present?

  			# property = Property.find_by(address: data['address'],city: data['city'],state: data['state'],zip: data['zip']) || new(data)
  			property = Property.find_by_id(data['id']) || new(data)

  			if property.new_record?
  				if !property.save
  					errors << row.fields.unshift((property.errors.to_a.unshift('create')).to_s)
  					# e << property.errors.to_a.unshift('create') << property.address
  				end
  			else
  				if !property.update(data)
  					errors << row.fields.unshift((property.errors.to_a.unshift('update')).to_s)
  					# e << property.errors.to_a.unshift('update') << property.address
  				end
  			end
  		end # ADDRESS not present end
    end # CSV loop end

  if errors.count > 1
		csv_string = CSV.generate do |csv|
		  errors.each_with_index do |item,i|
		  	csv << item
		  end
		end
	end

	return csv_string

	end
	# End import :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

	private

	def helper
		@helper ||= Class.new do
			include ActionView::Helpers::NumberHelper
		end.new
	end

end