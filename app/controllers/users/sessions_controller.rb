# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [ :create ]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create# 地図表示で追加しました
    super do |resource|
      flash[:just_logged_in]=true
    end
  end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :name ])
  end

  # サインイン後のリダイレクト先の指定
  def after_sign_in_path_for(resource)
    root_path
  end

  # サインアウト後のリダイレクト先の指定
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
