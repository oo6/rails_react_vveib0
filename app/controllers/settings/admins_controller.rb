class Settings::AdminsController < Settings::ApplicationController
  before_action :current_password_required, except: [:show]

  def show
  end

  def update
    if @user.update_attributes setting_params
      flash[:success] = '成功'
      redirect_to settings_admin_url
    else
      render :show
    end
  end

  def destroy
    log_out
    @user.destroy
    flash[:success] = '成功'
    redirect_to root_url
  end

  private
    def setting_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def current_password_required
      unless params[:current_password] && @user.authenticate(params[:current_password])
        flash.now[:danger] = "当前密码错误"
        render :show
      end
    end
end
