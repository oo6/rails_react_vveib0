class Admin::ApplicationController < ApplicationController
  layout 'admin'
  before_action :logged_in_user, :admin_required

  private
    def admin_required
      redirect_to root_url unless current_user.admin?
    end
end
