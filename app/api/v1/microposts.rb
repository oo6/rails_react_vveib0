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
          @micropost = Micropost.find_by(id: params[:id])
          correct_find!(@micropost)
        end

        desc "获取某条微博的评论列表"
        params do
          optional :page, type: Integer, default: 1
        end
        get :comments, each_serializer: CommentSerializer, root: 'comments' do
          render @micropost.comments.includes(:user).paginate(page: params[:page])
        end

        desc "评论某条微博"
        params do
          requires :access_token, type: String
          requires :content, type: String
        end
        post :comments, serializer: CommentSerializer, root: 'comment' do
          authenticate!
          @comment = @micropost.comments.new(content: params[:content], user: current_user)
          if @comment.save
            render @comment
          else
            error!({ error: @comment.errors.full_messages }, 400)
          end
        end
      end
    end
  end
end
