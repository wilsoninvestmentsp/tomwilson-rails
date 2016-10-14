class Link < ActiveRecord::Base

	belongs_to :property

	validates_presence_of :title,:link,:property_id

end