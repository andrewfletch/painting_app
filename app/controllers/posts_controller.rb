class PostsController < ApplicationController

  before_action :authenticate, only: [:admin, :new, :create, :edit, :update, :destroy]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category].blank?
      @posts = Post.all.order("created_at DESC").paginate(page: params[:page], per_page: 1)
    else
      @category_id = Category.find_by(name: params[:category]).id
      @posts = Post.where(category_id: @category_id).order("created_at DESC").paginate(page: params[:page], per_page: 1)
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "The post was created!"
      redirect_to @post  
    else 
      render 'new'
    end 
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Update successful"
      redirect_to @post  
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post destroyed"
    redirect_to root_path
  end

  def admin 
    redirect_to root_path if authenticate
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      admin_username = Rails.application.credentials.admin[:username]
      admin_password = Rails.application.credentials.admin[:password]
      session[:admin] = true if (username == admin_username && password == admin_password)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category_id, :image)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
