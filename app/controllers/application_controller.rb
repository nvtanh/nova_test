class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound do
    flash[:errors] = [I18n.t("errors.messages.record_not_found")]
    redirect_to root_path
  end
end
