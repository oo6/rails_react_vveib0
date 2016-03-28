class Settings::ProfilesController < Settings::ApplicationController
  def show
  end

  def update
    if @user.update_attributes setting_params
      flash[:success] = '成功'
      redirect_to settings_profile_url
    else
      render :show
    end
  end

  private
    def setting_params
      params.require(:user).permit(:name, :email, :locale)
    end
end
