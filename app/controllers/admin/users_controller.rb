class Admin::UsersController < ApplicationController
    before_action :set_user, only: [:show,:withdraw]
    def index
        @users = User.all
    end 
    
    def show
        @user = User.find(params[:id])
    end 
    def withdraw
        @user = User.find(params[:id])
        if @user.update(is_active: false)
          flash[:notice] = "退会処理を実行いたしました"
          redirect_to admin_users_path
        else
          flash[:alert] = "退会処理に失敗しました"
          redirect_to admin_user_path(@user)
        end
    end
private 
    def set_user
        @user = User.find(params[:id])
    end
    def user_params
        params.require(:user).permit(:name,:email,:is_active)
    end     
end
