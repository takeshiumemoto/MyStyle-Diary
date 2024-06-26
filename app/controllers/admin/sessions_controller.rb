# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  before_action :redirect_if_logged_in, only: [:new, :create]
  # before_action :configure_sign_in_params, only: [:create]
  def after_sign_in_path_for(resource)
    admin_posts_path
  end
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end
  
  private
  def redirect_if_logged_in
    if admin_signed_in?
      redirect_to admin_root_path, notice: "既にログインしています。"
    end
  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
