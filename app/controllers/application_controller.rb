class ApplicationController < ActionController::Base
  before_action :login_required
  helper_method :current_user
  add_flash_types :success, :info, :warning, :danger, :notice

  rescue_from Exception, with: :render_500
  if Rails.env.production?
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end
  
  def render_404
    render 'error/404', status: :not_found, layout: false, content_type: 'text/html'
  end

  private

  def render_500
    render 'error/500', status: :internal_server_error, layout: false, content_type: 'text/html'
  end

  private

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_path, danger: 'ログインして下さい' unless current_user
  end

  def require_admin_user
    redirect_to root_path, warning: '管理者権限が有りません' unless current_user.admin?
    # 今後管理者の他に属性が増えればレイアウトファイルを分けるべきだが、今回は一般と管理者なので同じコントローラで処理する
  end
end
