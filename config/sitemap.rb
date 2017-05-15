SitemapGenerator::Sitemap.default_host = 'http://www.tomwilsonproperties.com'
SitemapGenerator::Sitemap.compress = false
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_host = "http://res.cloudinary.com/#{ENV['CLOUDINARY_CLOUD_NAME']}"
SitemapGenerator::Sitemap.create do
  add syndications_path, priority: 0.7
  add properties_path, priority: 0.7
  add blogs_path, priority: 0.7
  add faq_path, priority: 0.7
  add financing_investments_path, priority: 0.7
  add property_management_path, priority: 0.7
  add jassets_path, priority: 0.7
  add events_path, priority: 0.7
  add radio_show_path, priority: 0.7
  add contact_us_path, priority: 0.7
  add users_path, priority: 0.7
  add our_difference_path, priority: 0.7
  add cn_path, priority: 0.7

  Blog.all_active_blogs.order('created_at DESC').each do |blog|
    add blog_path(blog), lastmod: blog.updated_at, priority: 0.8
  end

  Property.active.order('created_at DESC').each do |property|
    add property_path(property), lastmod: property.updated_at, priority: 0.9
  end
end
Cloudinary::Uploader.upload('tmp/sitemap.xml', resource_type: :auto, use_filename: true, use_root_path: true, unique_filename: false, overwrite: true)