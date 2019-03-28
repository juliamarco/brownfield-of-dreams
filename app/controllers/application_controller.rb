class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :list_tags

  add_flash_types :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    four_oh_four unless current_user
  end

  def four_oh_four
    render file: 'errors/not_found', status: 404
  end
end
