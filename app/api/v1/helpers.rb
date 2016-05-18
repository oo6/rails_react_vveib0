module V1
  module Helpers
    def current_user
      User.find_by(access_token: params[:access_token]) if params[:access_token]
    end

    def authenticate!
      error!('401 Unauthenticated', 401) unless current_user
    end

    def correct_find!(model)
      error!('404 Not Found', 404) unless model
    end
  end
end
