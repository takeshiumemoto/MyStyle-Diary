class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.new(user: current_user)
    if favorite.save
      respond_to do |format|
        format.html { redirect_to @post }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: 'いいねに失敗しました。' }
        format.js { render js: "alert('いいねに失敗しました。');" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.find_by(user: current_user)
    if favorite&.destroy
      respond_to do |format|
        format.html { redirect_to @post }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: 'いいねの解除に失敗しました。' }
        format.js { render js: "alert('いいねの解除に失敗しました。');" }
      end
    end
  end 
  
  def index 
    @favorites = current_user.favorites.includes(:post).order('created_at DESC')
  end
end   
