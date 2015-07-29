class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.new comment_params.merge(user: current_user)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @micropost }
        format.js
      end
    end
  end

  def destroy
    @comment = current_user.comments.find_by(id: params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
