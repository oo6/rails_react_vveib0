class MentionsController < ApplicationController
  before_action :logged_in_user

  def micropost
    @microposts = current_user.notifications.named('mention').includes(:subject).paginate(page: params[:page])
  end

  def comment
    @microposts = current_user.notifications.named('mention').includes(:subject).paginate(page: params[:page])
  end
end
