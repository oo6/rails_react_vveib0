module V1
  class Root < Grape::API
    version 'v1'

    desc "用户登录验证"
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post :login do
      @user = User.find_by(email: params[:email].downcase)
      if @user && @user.authenticate(params[:password])
        access_token = User.new_token
        @user.update_attribute :access_token, access_token

        { access_token: access_token }
      else
        error!('401 Unauthenticated', 401)
      end
    end
  end
end
