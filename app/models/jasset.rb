class Jasset < ActiveRecord::Base

	mount_uploader :image,AssetUploader

	validates_presence_of :title,:link_name,:link_uri
	
end