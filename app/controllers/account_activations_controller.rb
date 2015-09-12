class AccountActivationsController < ApplicationController
  def index
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:activation_token])
      user.activate
      log_in user
      flash[:success] = "账号激活成功，愉快的去玩耍吧！"
      redirect_to user_path(user)
    else
      flash[:danger] = "无效的激活链接！"
      redirect_to root_url
    end
  end
end
