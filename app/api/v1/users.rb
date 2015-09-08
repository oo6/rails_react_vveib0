module V1
  class Users < Grape::API
    resource :users do
      namespace ':name' do
        before do
          @user = User.find_by(name: params[:name])
        end

        desc "获取用户详细资料"
        get '', serializer: UserDetailSerializer, root: 'user' do
          if @user
            render @user
          else
            error!('404 Not Found', 404)
          end
        end
      end
    end
  end
end
