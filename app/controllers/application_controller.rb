class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :add_flash_messages_from_params


  protected

    helper_method :current_time_zone

    def current_time_zone
      current_user.try(:time_zone) || 'Pacific Time (US & Canada)'
    end

  private

    def add_flash_messages_from_params
      flash.now[:notice] = params[:notice] if params[:notice]
      flash.now[:error] = params[:error] if params[:error]
    end
end
