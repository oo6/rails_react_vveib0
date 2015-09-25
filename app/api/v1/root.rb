module V1
  class Root < Grape::API
    version 'v1'

    formatter :json, Grape::Formatter::ActiveModelSerializers

    helpers V1::Helpers
    mount V1::Microposts
    mount V1::Users
    mount V1::Likes

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

        { access_token: access_token, current_user_name: @user.name }
      else
        error!('401 Unauthenticated', 401)
      end
    end

    desc "获取微博动态流"
    params do
      requires :access_token, type: String
      optional :page, type: Integer, default: 1
    end
    get :home_feed, each_serializer: MicropostDetailSerializer, root: 'microposts' do
      authenticate!
      render current_user.feed.includes(:user).paginate(page: params[:page])
    end

    desc "用户注册"
    params do
      requires :name, type: String
      requires :email, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
    end
    post :signup do
      @user = User.new(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
      if @user.save
        access_token = User.new_token
        @user.update_attribute :access_token, access_token

        { access_token: access_token, current_user_name: @user.name }
      else
        { error: @user.errors.full_messages }
      end
    end

    desc "判断 name_or_email 是否可用"
    params do
      requires :name_or_email, type: String
    end
    get :test, root: 'user' do
      if params[:name_or_email].include?('@')
        if @user = User.find_by(email: params[:name_or_email])
          render @user
        else
          { ok: 1 }
        end
      else
        if @user = User.find_by(name: params[:name_or_email])
          render @user
        else
          { ok: 1 }
        end
      end
    end
  end
end
