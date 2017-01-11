class Blog < ActiveRecord::Base
  mount_uploader :image, BlogUploader
  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :all_recent_blogs, -> { all.order('created_at DESC') }
  scope :recent_blogs, -> (blog_id) { all_recent_blogs.where.not(id: blog_id).limit(6) }

  validates :title, :summary, :content, presence: true

  def formatted_date
    date.strftime('%B %d, %Y')
  end
end