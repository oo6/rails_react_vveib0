class SearchController < ApplicationController
  def index
    @user = User.find_by(name: params[:q])
  end
end
