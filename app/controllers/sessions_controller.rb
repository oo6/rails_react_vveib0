class SessionsController < ApplicationController
  def new
  end

  def create
    email = login_params[:email].downcase
    user = User.find_by email: email
    if user && user.authenticate(login_params[:password])
      log_in user
      # log_in user, 等同于 log_in user_path(user)
      login_params[:remember_me] == '1' ? remember(user) : forget(user)
      # debugger
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
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
