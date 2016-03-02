class SessionsController < ApplicationController
  def new
  end

  def create
    email = login_params[:email].downcase
    user = User.find_by email: email
    if user && user.authenticate(login_params[:password])
      if user.activated?
        log_in user
        # log_in user, 等同于 log_in user_path(user)
        login_params[:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or root_url
      else
        message = "账户没有被激活，请注意查收邮件以激活或联系客服激活！"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = '无效的邮箱或密码，请仔细检查是否输入错误！'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
    def login_params
      params.require(:session).permit(:email, :password, :remember_me)
    end
end
