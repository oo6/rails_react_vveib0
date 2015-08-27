class Settings::BindsController < Settings::ApplicationController
  def show
    store_location
  end

  def destroy
    flash[:success] = '成功解除绑定'
    current_user.authentications.where(provider: params[:provider]).first.destroy
    redirect_to settings_binds_path
  end
end
