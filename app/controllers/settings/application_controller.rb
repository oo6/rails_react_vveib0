class Settings::ApplicationController < ApplicationController
  before_action :logged_in_user, :set_user

  private
    def set_user
      @user = current_user
    end
end
