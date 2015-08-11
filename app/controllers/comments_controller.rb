class CommentsController < ApplicationController
  before_action :logged_in_user
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.new comment_params.merge(user: current_user)
    if @comment.save
      Notification.create(user: @micropost.user, subject: @comment, name: 'comment')

      @comment.create_mention_notification

      respond_to do |format|
        format.html { redirect_to @micropost }
        format.js
      end
    end
  end

  def destroy
    @comment = current_user.comments.find params[:id]
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def inbox
    @subject = current_user.notifications.named('comment').includes(:subject).paginate(page: params[:page])
  end

  def outbox
    @comments = current_user.comments.paginate(page: params[:page])
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
