class Users::CurrentUserController < ApplicationController
  def fetch_current_user
    if user_signed_in?
      render json: { user: current_user.as_json.merge(role: current_user.role_before_type_cast) }
    else
      render json: { error: "User not signed in" }, status: :unauthorized
    end
  end
end
