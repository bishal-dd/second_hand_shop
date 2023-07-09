# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  include Common
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.save
    render_resources(resource)
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end


end
