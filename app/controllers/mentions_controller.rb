class MentionsController < ApplicationController
  before_action :logged_in_user

  def micropost
    @notifications = current_user.notifications.named('mention').where(subject_type: Micropost).paginate(page: params[:page])
  end

  def comment
    @notifications = current_user.notifications.named('mention').where(subject_type: Comment).paginate(page: params[:page])
  end
end
