require 'pry'
class Users::SessionsController < Devise::SessionsController
  include Common
  include ActionController::MimeResponds
  skip_before_action :verify_signed_out_user, only: :destroy
  skip_before_action :verify_authenticity_token

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    role = resource.role # Get the role attribute of the signed-in user
    render_resources(resource)
  end


  def destroy
    sign_out(resource_name) # Signs out the currently signed-in user
    render json: { status: "success", message: "Signed out successfully" }
  end



  private

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

end
