class User < ActiveRecord::Base
  has_secure_password
  mount_uploader :image,ProfileUploader
  validates_presence_of :name,:role,:description,:team

  def raw_team
    self.team.capitalize
  end
end