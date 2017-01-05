class Blog < ActiveRecord::Base
  mount_uploader :image, BlogUploader
  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :all_recent_blogs, -> { all.order('created_at DESC') }
  scope :recent_blogs, -> { all_recent_blogs.first(6) }

  validates :title, :summary, :content, presence: true

  def blog_time
    date.strftime('%B %d, %Y')
  end
end