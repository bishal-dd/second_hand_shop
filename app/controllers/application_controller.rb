class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  private

  def authenticate_admin!
    unless current_user&.admin?
      render json: { status: "error", message: "Unauthorized access" }, status: :unauthorized
    end
  end

  def authenticate_user!
    unless current_user&.user?
      render json: { status: "error", message: "Unauthorized access" }, status: :unauthorized
    end
  end
end
