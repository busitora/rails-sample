class ApplicationController < ActionController::Base
  before_action :login_required
  helper_method :current_user
  add_flash_types :success, :info, :warning, :danger, :notice

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_path, danger: 'ログインして下さい' unless current_user
  end
end
