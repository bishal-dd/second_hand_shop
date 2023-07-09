class Users::SessionsController < Devise::SessionsController
  include Common
  include ActionController::MimeResponds
  skip_before_action :verify_signed_out_user, only: :destroy
  skip_before_action :verify_authenticity_token

  before_action :set_devise_mapping, only: [:current_user]

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
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

  def set_devise_mapping
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  # Override respond_to to explicitly specify JSON format
end
