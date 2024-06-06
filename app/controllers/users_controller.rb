class UsersController < ApplicationController
    before_action :is_matching_login_user,except:[:index]
    def index
        @post = Post.new 
        @users = User.all
    end 
    
    def show
       @post = Post.new
       @user = User.find(params[:id])
    end     
    
    private 
        def is_matching_login_user
            unless user_signed_in?&&current_user.id==params[:id].to_i
                flash[:alert]="ログインしてください"
                redirect_to root_path
            end 
        end     
end
