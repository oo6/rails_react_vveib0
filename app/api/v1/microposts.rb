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

      namespace ':id' do
        before do
          @micropost = Micropost.find(params[:id])
        end

        desc "获取某条微博的评论列表"
        params do
          optional :page, type: Integer, default: 1
        end
        get :comments, each_serializer: CommentSerializer, root: 'comments' do
          render @micropost.comments.includes(:user).paginate(page: params[:page])
        end
      end
    end
  end
end
