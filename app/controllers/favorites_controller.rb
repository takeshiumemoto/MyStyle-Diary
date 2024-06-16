# app/controllers/favorites_controller.rb
class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @favorite = Favorite.new(user_id: current_user.id, post_id: @post.id)
    if @favorite.save
      redirect_to request.referer, notice: 'いいねをしました。'
    else
      redirect_to request.referer, alert: 'いいねをできませんでした。'
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, post_id: @post.id)
    if @favorite&.destroy
       redirect_to request.referer, notice: 'いいねを削除しました。'
    else
      redirect_to request.referer, alert: 'いいねを削除できませんでした。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
