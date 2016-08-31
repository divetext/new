class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :current_notifications

  def current_notifications
    if user_signed_in?
    @notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).includes({comment: [:blog]})
    @notifications_count = Notification.where(recipient_id: current_user).order(created_at: :desc).unread.count
    end
  end

   PERMISSIBLE_ATTRIBUTES = %i(name avatar avatar_cache)


  #例外処理　開始
  protect_from_forgery with: :exception

  # 他のエラーハンドリングでキャッチできなかった場合に
  # 500 Internal Server Error(システムエラー)を発生させる
  # NOTE: rescue_from は下から評価されるので記載箇所はここが正解
  rescue_from Exception, with: :handle_500 unless Rails.env.development?

  # 例外に合わせたエラーハンドリング
  # 404 Not Found リソースが見つからない。アクセス権がない場合にも使用される
  rescue_from ActionController::RoutingError, with: :handle_404 unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound,   with: :handle_404 unless Rails.env.development?

  # エラーハンドリング処理
  def handle_500(exception = nil)
    logger.info "Rendering 500 with exception: #{exception.message}" if exception

    if request.xhr?
      # Ajaxのための処理
      render json: { error: '500 error' }, status: 500
    else
      render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
    end
  end

  def handle_404(exception = nil)
    logger.info "Rendering 404 with exception: #{exception.message}" if exception

    if request.xhr?
      # Ajaxのための処理
      render json: { error: '404 error' }, status: 404
    else
      render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
    end
  end
  #例外処理　終了

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

private
def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: PERMISSIBLE_ATTRIBUTES)
      devise_parameter_sanitizer.permit(:account_update, keys: PERMISSIBLE_ATTRIBUTES)
end

end
