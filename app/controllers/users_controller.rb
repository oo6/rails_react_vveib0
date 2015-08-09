class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(name: params[:name]) || User.find(params[:name])
    @microposts = @user.microposts.paginate(page: params[:page])
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

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes(user_params)
      flash[:success] = "个人资料更新成功！"
      redirect_to @user
    else
      render :edit
    end
  end

  def following
    @title = "关注"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render :show_follow
  end

  def followers
    @title = "粉丝"
    @user = User.find(params[:id])
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
