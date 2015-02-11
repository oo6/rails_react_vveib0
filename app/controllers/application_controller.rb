class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :page_identifier

  def page_identifier
    "#{self.class.to_s.downcase.gsub('::','-').gsub('controller','')} #{action_name}"
  end
end
