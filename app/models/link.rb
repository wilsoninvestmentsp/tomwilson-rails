class Link < ActiveRecord::Base

	belongs_to :property

	validates_presence_of :title,:property_id
	validates :link, format: { with: /(^(https?:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, message: "Please Enter Valid Link" }, allow_blank: true
	def formatted_link
		(link[/\Ahttp:\/\//] || link[/\Ahttps:\/\//]) ? link : "http://#{link}"
	end

end