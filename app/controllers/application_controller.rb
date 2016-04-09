class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper, UsersHelper
  helper_method :page_identifier

  before_action :set_locale

  def page_identifier
    "#{self.class.to_s.downcase.gsub('::','-').gsub('controller','')}-page #{action_name}"
  end

  private
    # 确保用户已登录
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "请登陆后操作，谢谢！"
        redirect_to login_url
      end
    end

    def set_locale
      I18n.locale = current_user.try(:locale) || I18n.default_locale
    end

    def generate_qiniu_upload_token
      put_policy = Qiniu::Auth::PutPolicy.new('vveib0')
      Qiniu::Auth.generate_uptoken(put_policy)
    end
end
