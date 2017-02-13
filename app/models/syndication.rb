class Syndication < ActiveRecord::Base
  mount_uploader :image, SyndicationUploader
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :annual_returns, dependent: :destroy
  accepts_nested_attributes_for :annual_returns, reject_if: :all_blank, allow_destroy: true
end