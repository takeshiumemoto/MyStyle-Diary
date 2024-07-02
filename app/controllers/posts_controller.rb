class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    tags = Vision.get_image_data(post_params[:image])
    if @post.save
      tags.each do |tag|
        @post.tags.create(name: tag)
      end   
      redirect_to posts_path, notice: '投稿が作成されました。'
    else
      @user = current_user
      @posts = Post.all
      flash.now[:alert]='投稿に失敗しました。入力内容を確認してください。'
      render :index
    end
  end

  
  def index
    if params[:latest]
      @posts = Post.latest.page(params[:page]).per(8)
    elsif params[:old]
      @posts = Post.old.page(params[:page]).per(8)
    elsif params[:favorite_count]
      @posts = Post.favorite_count.page(params[:page]).per(8)
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(8)
    end
    @post = Post.new
    @user = current_user if user_signed_in?
  end


  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user), notice: '投稿が削除されました。'
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :content)
  end

  def is_matching_login_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path, alert: '権限がありません。'
    end
  end
end
