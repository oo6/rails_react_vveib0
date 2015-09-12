class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    if @user = User.find_by(name: params[:name])
      @microposts = @user.microposts.paginate(page: params[:page])
    else
      redirect_to search_path(q: params[:name])
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "请检查你的邮箱，并完成激活"
      redirect_to root_url
    else
      render :new
    end
  end

  def following
    @title = "关注"
    @user  = User.find_by(name: params[:name])
    @users = @user.following.paginate(page: params[:page])
    render :show_follow
  end

  def followers
    @title = "粉丝"
    @user = User.find_by(name: params[:name])
    @users = @user.followers.paginate(page: params[:page])
    render :show_follow
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                                  :password_confirmation)
    end

    # 确保是正确的用户
    def correct_user
      @user = User.find params[:id]
      redirect_to(root_url) unless current_user?(@user)
    end
end
