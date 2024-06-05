class UsersController < ApplicationController
    def index
        @post = Post.new 
        @users = User.all
    end 
    
    def show
       @post = Post.new
       @user = User.find(params[:id])
    end     
end
