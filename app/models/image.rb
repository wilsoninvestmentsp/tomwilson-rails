class Image < ActiveRecord::Base

	belongs_to :property
	
	mount_uploader :image,PropertyUploader

end