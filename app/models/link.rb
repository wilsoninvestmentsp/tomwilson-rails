class Link < ActiveRecord::Base

	belongs_to :property

	validates_presence_of :title,:property_id

end