module V1
  module Helpers
    def current_user
      @current_user ||= User.where(access_token: params[:access_token]).first
    end

    def authenticate!
      error!('401 Unauthenticated', 401) unless current_user
    end
  end
end