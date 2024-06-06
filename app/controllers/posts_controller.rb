class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: '投稿が成功しました'
    else
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc).limit(8)
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿が削除されました'
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :content)
  end

  def is_matching_login_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path, alert: 'ログインが必要です'
    end
  end
end
