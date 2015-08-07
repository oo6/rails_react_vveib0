class AuthenticationsController < ApplicationController
  def callback    
    auth = Authentication.find_by uid: auth_hash["uid"]
    if auth
      log_in auth.user
    else
      user = User.find_or_create_from_auth_hash(user_params)
      user.activate
      user.authentications.create(provider: params[:provider], uid: auth_hash["uid"])

      log_in user
    end
    redirect_to root_url
  end

  private
    def auth_hash
      request.env['omniauth.auth']
    end

    def user_params
      password = User.new_token
      {
        name: auth_hash["info"]["name"],
        email: auth_hash["info"]["email"],
        password: password,
        password_confirmation: password
      }
    end
end
