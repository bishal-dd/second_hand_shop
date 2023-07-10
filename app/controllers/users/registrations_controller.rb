# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  include Common
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.role = :user # Set the role as "user"
    resource.save
    render_resources(resource)
  end

  def add_admin
    build_resource(sign_up_params)
    resource.role = :admin # Set the role as "admin"
    resource.save
    render_resources(resource)
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end


end
