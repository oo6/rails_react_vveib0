module V1
  class Likes < Grape::API
    resource :likes do
      desc "点赞微博或评论"
      params do
        requires :access_token, type: String
        requires :subject_id, type: Integer
        requires :subject_type, type: String
      end
      post '' do
        authenticate!
        if params[:subject_type] == 'Micropost'
          @subject = Micropost.find(params[:subject_id])
        else
          @subject = Comment.find(params[:subject_id])
        end
        correct_find!(@subject)

        @subject.likes.find_or_create_by user: current_user
        { ok: 1 }
      end

      desc "取消点赞微博或评论"
      params do
        requires :access_token, type: String
        requires :subject_id, type: Integer
        requires :subject_type, type: String
      end
      delete '' do
        authenticate!
        if params[:subject_type] == 'Micropost'
          @subject = Micropost.find(params[:subject_id])
        else
          @subject = Comment.find(params[:subject_id])
        end
        correct_find!(@subject)

        @subject.likes.where(user: current_user).delete_all
        { ok: 1 }
      end
    end
  end
end
