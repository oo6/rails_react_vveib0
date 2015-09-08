module V1
  class Microposts < Grape::API
    resource :microposts do
      desc "发布微博"
      params do
        requires :access_token, type: String
        requires :content, type: String
      end
      post '', serializer: MicropostSerializer, root: 'micropost' do
        authenticate!
        @micropost = current_user.microposts.new(content: params[:content])
        if @micropost.save
          render @micropost
        else
          error!({ error: @micropost.errors.full_messages }, 400)
        end
      end
    end
  end
end
