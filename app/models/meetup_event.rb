class MeetupEvent < ActiveRecord::Base
  mount_uploader :meetup_image, MeetupEventImageUploader

  validates_presence_of :title, :description, :status, :url

end
