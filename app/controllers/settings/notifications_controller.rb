class Settings::NotificationsController < Settings::ApplicationController
  def show
  end

  def update
    if @user.update_attributes setting_params
      flash[:success] = '成功'
      redirect_to settings_notifications_url
    else
      render :show
    end
  end

  private
    def setting_params
      params.require(:user).permit(:mentions_permission, :comments_permission,
                                                          :likes_permission)
    end
end
