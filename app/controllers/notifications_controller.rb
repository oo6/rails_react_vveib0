class NotificationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :destroy]
  after_action :mark_all_as_read, only: [:unread]

  def index
    @notifications = current_user.notifications.includes(:subject).paginate(page: params[:page])
  end

  def destroy
    @notification = current_user.notifications.find params[:id]
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.js
    end
  end

  def unread
    @notifications = current_user.notifications.unread.includes(:subject).paginate(page: params[:page])
    render :index
  end

  def get_unread_count
    count = current_user.notifications.unread.count
    respond_to do |format|
      format.json {
        render json: { unread_count: count }
      }
    end
  end

  def comment
    @notifications = current_user.notifications.named('comment').includes(:subject).paginate(page: params[:page])
    render :index
  end

  def mention
    @notifications = current_user.notifications.named('mention').includes(:subject).paginate(page: params[:page])
    render :index
  end

  def like
    @notifications = current_user.notifications.named('like').includes(:subject).paginate(page: params[:page])
    render :index
  end

  private
    def mark_all_as_read
      current_user.notifications.unread.update_all(read: true,
                                                    updated_at: Time.now.utc)
    end
end
