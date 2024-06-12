class Admin::UsersController < ApplicationController
    def index
        @users = User.all
    end 
    
    def show
        @user = User.find(params(:id))
    end 
    
    def edit 
        @user = User.find(params(:id))
    end 
    
    def update
        if @user.update(user_params)
            flash[:success]="ユーザー情報を更新しました。"
        else 
            flash[:danger]="ユーザー情報の更新に失敗しました"
        end 
    end 
    
    private 
        def user_params
            params.require(:user).permit(:name)
        end     
end
