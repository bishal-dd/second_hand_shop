class Users::PasswordsController < Devise::PasswordsController
  skip_before_action :verify_authenticity_token

  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    super
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  def after_sending_reset_password_instructions_path_for(resource_name)
    # Return the appropriate response for your API
    { message: 'Password reset instructions sent' }
  end
end
