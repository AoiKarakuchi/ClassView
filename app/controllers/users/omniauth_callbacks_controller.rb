# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :all

  def all
    # ユーザー情報を取得
    @user = User.from_omniauth(request.env["omniauth.auth"])
    provider = __callee__.to_s

    # ユーザーを検索または作成
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      # 認証データを覚えておく。
      session["devise.user_attributes"] = @user.attributes
      # ユーザーを新規登録ページに転送
      redirect_to new_user_registration_url(from_omniauth_callback: "1")
    end
  end

  def failure
    redirect_to root_path
  end

  alias_method :twitter, :all
  alias_method :google_oauth2, :all
end
