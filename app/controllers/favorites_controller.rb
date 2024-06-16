# app/controllers/favorites_controller.rb
class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @favorite = Favorite.new(user_id: current_user.id, post_id: @post.id)
    if @favorite.save
      redirect_to request.referer, notice: 'お気に入りに追加しました。'
    else
      redirect_to request.referer, alert: 'お気に入りに追加できませんでした。'
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, post_id: @post.id)
    if @favorite&.destroy
       redirect_to request.referer, notice: 'お気に入りを解除しました。'
    else
      redirect_to request.referer, alert: 'お気に入りを解除できませんでした。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
