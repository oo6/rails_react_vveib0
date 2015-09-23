class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by(name: params[:name])
    current_user.follow(@user) unless current_user.following?(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = User.find_by(name: params[:name])
    current_user.unfollow(@user) if current_user.following?(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
