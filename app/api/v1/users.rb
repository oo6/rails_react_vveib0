module V1
  class Users < Grape::API
    resource :users do
      namespace ':name' do
        before do
          @user = User.find_by(name: params[:name])
          correct_find!(@user)
        end

        desc "获取用户详细资料"
        params do
          optional :access_token, type: String
        end
        get '', serializer: UserDetailSerializer, root: 'user' do
          render @user
        end

        desc "获取某个用户发布的微博"
        params do
          optional :page, type: Integer, default: 1
          optional :access_token, type: String
        end
        get :microposts, each_serializer: MicropostDetailSerializer, root: 'microposts' do
          render @user.microposts.paginate(page: params[:page])
        end

        desc "关注用户"
        params do
          requires :access_token, type: String
        end
        post :follow do
          authenticate!
          current_user.follow(@user) unless current_user.following?(@user)
          { ok: 1 }
        end

        desc "取消关注用户"
        params do
          requires :access_token, type: String
        end
        delete :follow do
          authenticate!
          current_user.unfollow(@user) if current_user.following?(@user)
          { ok: 1 }
        end
      end
    end
  end
end
