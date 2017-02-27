class BlogsController < ApplicationController
  before_action :authorize, except: [:index,:show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.blogs_by_user(current_user).page(params[:page]).per(Settings.pagination.blogs.per_page)
    title = 'Articles on Real Estate Syndication and Property Investment'
    description = 'By our articles we guide how to invest in property and how investors can make profit through syndication of real estate.'
    prepare_meta_tags(title: title,
                      description: description,
                      twitter: {title: title, description: description},
                      og: {title: title, description: description}
                      )
  end

  def new
    @blog = Blog.new
    prepare_meta_tags(title: 'Add Article - Wilson Investment Properties, Inc.')
  end

  def create
    @blog = Blog.new(blog_params.merge!({date: Date.today()}))
    if @blog.save
      redirect_to @blog, flash: {success: "'#{@blog.title}' was successfully created!"}
    else
      render :new
    end
  end

  def show
    @blogs = Blog.recent_blogs_by_user(current_user, @blog.id)
    description =  @blog.summary.truncate(Settings.truncate.blog.meta_description).tr('“,”,"', '')
    prepare_meta_tags(title: @blog.title,
                      description: description,
                      image: @blog.image.thumb.url,
                      twitter: {title: @blog.title, description: description, image: @blog.image.thumb.url},
                      og: {title: @blog.title, description: description, image: @blog.image.thumb.url}
                      )
  end

  def edit
    prepare_meta_tags(title: 'Edit Article - Wilson Investment Properties, Inc.')
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, flash: {success: "'#{@blog.title}' was successfully updated!"}
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, flash: {danger: "'#{@blog.title}' was successfully deleted."}
  end

  private

  def set_blog
    @blog = Blog.where(slug: params[:id]).first
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :summary, :author, :status, :image)
  end
end