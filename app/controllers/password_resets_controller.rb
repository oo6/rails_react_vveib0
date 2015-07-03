class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "重置密码的邮件已经发送，请注意查收！"
      redirect_to root_url
    else
      flash.now[:danger] = "邮箱地址找不到！"
      render :new
    end
  end

  def edit
  end

  def update
    if both_passwords_blank?
      flash.now[:danger] = "密码或密码确认不能为空！"
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "密码已经被重置，并登录！"
      redirect_to root_url
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 确保是有效用户
    def valid_user
      redirect_to root_url unless(@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
    end

    # 如果密码和密码确认都为空，返回 true
    def both_passwords_blank?
      params[:user][:password].blank? &&
      params[:user][:password_confirmation].blank?
    end

    # 检查重设令牌是否过期
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "重置密码链接已经失效！"
        redirect_to new_password_reset_url
      end
    end
end
