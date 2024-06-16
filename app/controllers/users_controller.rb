class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :is_matching_login_user, only: [:edit, :update, :destroy]
    def index
        @post = Post.new 
        @user = current_user
        @users = User.all 
        @users = User.where(is_active: true)
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
        user = User.find(params[:id])
        @users = user.following_users
    end 
    
    def followers
        user = User.find(params[:id])
        @users = user.follower_users
    end     
private 
    def is_matching_login_user
        unless user_signed_in?&&current_user.id==params[:id].to_i
            flash[:alert]="ログインしてください"
            redirect_to root_path
        end 
    end     
        
    def user_params
        params.require(:user).permit(:name,:profile_image)
    end     
end
