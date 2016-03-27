class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.new comment_params.merge(user: current_user)
    if @comment.save
      @comment.notifications.create(user: @micropost.user, name: 'comment') if current_user != @micropost.user
      @comment.create_mention_notification

      # 创建话题
      @comment.content.scan(/#([\w]+|[\u4e00-\u9fa5]+)#/) do |match|
        topic = current_user.topics.find_or_create_by(content: $1)
        @comment.topic_relationships.create(topic: topic)
      end

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
    @notifications = current_user.notifications.named('comment').includes(:subject).paginate(page: params[:page])
  end

  def outbox
    @comments = current_user.comments.paginate(page: params[:page])
  end

  def reply
    @comment = Comment.find params[:id]
    @children = @comment.children.new comment_params.merge(user: current_user).merge(micropost: @comment.micropost)
    if @children.save
      # @comment.notifications.create(user: @micropost.user, name: 'comment') if current_user != @micropost.user
      # @comment.create_mention_notification

      respond_to do |format|
        format.html { redirect_to @comment.micropost }
        format.js
      end
    end
  end

  def ancestors
    comment = Comment.find params[:id]
    @comments = comment.path
    respond_to do |format|
      format.js
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
