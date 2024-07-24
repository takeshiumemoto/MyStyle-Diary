class SearchesController < ApplicationController
    before_action :authenticate_user!
    
    def search
        @range = params[:range]
        if @range == "User"
            @users = User.looks(params[:search],params[:word]).page(params[:page]).per(10)
        else
            @posts = Post.looks(params[:search],params[:word]).page(params[:page]).per(10)
        end     
    end    
    
end
