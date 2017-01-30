class Blog < ActiveRecord::Base
  mount_uploader :image, BlogUploader
  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :all_blogs, -> { all.order('created_at DESC') }
  scope :recent_blogs, -> (blog_id) { all_blogs.where.not(id: blog_id).limit(6) }
  scope :all_active_blogs, -> { all_blogs.active }
  scope :recent_active_blogs, -> (blog_id) { all_active_blogs.where.not(id: blog_id).limit(6) }

  validates :title, :summary, :content, presence: true

  enum status: { inactive: 0, active: 1 }

  def formatted_date
    date.strftime('%B %d, %Y')
  end

  def self.blogs_by_user(user)
    user ? all_blogs : all_active_blogs
  end

  def self.recent_blogs_by_user(user, blog)
    user ? recent_blogs(blog) : recent_active_blogs(blog)
  end
end