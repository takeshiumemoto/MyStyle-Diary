class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @post = Post.new 
    @user = current_user
    @users = User.where(is_active: true).page(params[:page]).per(8)
  end 

  def show
    @post = Post.new
    @user = User.find(params[:id])
  end     

  def edit 
    @user = User.find(params[:id])
  end 

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'プロフィールが更新されました。'
    else
      render :edit, alert: 'プロフィールの更新に失敗しました。'
    end
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.following_users.page(params[:page]).per(8)
  end 

  def followers
    @user = User.find(params[:id])
    @followers = @user.follower_users.page(params[:page]).per(8)
  end 

  def check
  end 

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end     

private 
  def is_matching_login_user
    unless user_signed_in? && current_user.id == params[:id].to_i
      flash[:alert] = "ログインしてください"
      redirect_to root_path
    end 
  end     

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end     
end
