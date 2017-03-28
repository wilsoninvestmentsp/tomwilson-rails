class BlogsController < ApplicationController
  before_action :authorize, except: [:index,:show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.blogs_by_user(current_user).page(params[:page]).per(Settings.pagination.blogs.per_page)
  end

  def new
    @blog = Blog.new
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
    @description = @blog.summary.truncate(Settings.truncate.blog.meta_description).tr('“,”,"', '')
  end

  def edit
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
    redirect_to blogs_path, flash: {danger: "Article '#{params[:id]}' not found"} if @blog.nil?
  end
 
  def blog_params
    params.require(:blog).permit(:title, :content, :summary, :author, :status, :image)
  end
end