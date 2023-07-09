# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include Common
  include ActionController::MimeResponds
  skip_before_action :verify_signed_out_user, only: :destroy
  skip_before_action :verify_authenticity_token


  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render_resources(resource)
  end

  def destroy
    sign_out(resource_name) # Signs out the currently signed-in user
    render json: { status: "success", message: "Signed out successfully" }
  end

  def current_user
    if user_signed_in?
      user = current_user
      render json: { user: user }
    else
      render json: { error: "User not signed in" }, status: :unauthorized
    end
  end
  private

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
