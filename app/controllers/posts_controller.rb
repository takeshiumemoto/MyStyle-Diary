class PostsController < ApplicationController
    def new
        @post = Post.new
    end    
    def create
     @post = Post.new(post_params)
     @post.user_id = current_user.id
     if @post.save
      redirect_to posts_path, notice: '投稿が作成されました。'
     else
      render :new
     end
    end
    
    def index
        @post = Post.new
        @posts = Post.order(created_at: :desc).limit(8)
    end 
    
    def show
        @post = Post.new
        @post = Post.params[:id]
    end     
    
    def edit
        @post = Post.params[:id]
    end 
    
    private
    def post_params
        params.require(:post).permit(:title,:content,:image)
    end     
end
