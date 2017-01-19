class Link < ActiveRecord::Base

	belongs_to :property

	validates_presence_of :title,:property_id

  def formatted_link
    (link[/\Ahttp:\/\//] || link[/\Ahttps:\/\//]) ? link : "http://#{link}"
  end

end