module V1
  class Root < Grape::API
    version 'v1'

    formatter :json, Grape::Formatter::ActiveModelSerializers

    helpers V1::Helpers

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

    desc "获取微博动态流"
    params do
      requires :access_token, type: String
      optional :page, type: Integer, default: 1
    end
    get :home_feed, each_serializer: MicropostSerializer, root: 'microposts' do
      authenticate!
      render current_user.feed.includes(:user).paginate(page: params[:page])
    end
  end
end
