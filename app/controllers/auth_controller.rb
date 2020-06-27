class AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [:oauth_callback]

  def oauth_callback
    if team_member?
      if auth_email.present?
        user = User.find_or_create_by(email: auth_email)
        sign_in(user)
        flash[:success] = I18n.t('controllers.auth_controller.successes.oauth_callback')
        redirect_to root_path
      else
        render plain: "Please make sure your email address is public on your GitHub profile" and return
      end
    else
      render :forbidden
    end
  end

  private

  def team_member?
    auth_hash.credentials.team_member?
  end

  def auth_email
    info.email || auth_hash.credentials["email"].first
  end

  def info
    auth_hash.info
  end

  def auth_hash
    request.env["omniauth.auth"]
  end
end
