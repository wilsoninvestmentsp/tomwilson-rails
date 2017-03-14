SitemapGenerator::Sitemap.default_host = 'http://www.tomwilsonproperties.com'
SitemapGenerator::Sitemap.compress = false
SitemapGenerator::Sitemap.create do
  add syndications_path, priority: 0.8, changefreq: 'weekly'
  add properties_path, priority: 0.8, changefreq: 'weekly'
  add blogs_path, priority: 0.8, changefreq: 'weekly'
  add faq_path, priority: 0.8, changefreq: 'weekly'
  add financing_investments_path, priority: 0.8, changefreq: 'weekly'
  add property_management_path, priority: 0.8, changefreq: 'weekly'
  add jassets_path, priority: 0.8, changefreq: 'weekly'
  add events_path, priority: 0.8, changefreq: 'weekly'
  add radio_show_path, priority: 0.8, changefreq: 'weekly'
  add contact_us_path, priority: 0.8, changefreq: 'weekly'
  add users_path, priority: 0.8, changefreq: 'weekly'
  add our_difference_path, priority: 0.8, changefreq: 'weekly'
  add cn_path, priority: 0.8, changefreq: 'weekly'

  Blog.all_active_blogs.order('created_at DESC').each do |blog|
    add blog_path(blog), lastmod: blog.updated_at, priority: 0.8
  end

  Property.active.order('created_at DESC').each do |property|
    add property_path(property), lastmod: property.updated_at, priority: 0.8
  end
end