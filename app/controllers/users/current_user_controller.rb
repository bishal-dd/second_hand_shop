class Users::CurrentUserController < ApplicationController
  def fetch_current_user
    if user_signed_in?
      render json: { user: current_user }
    else
      render json: { error: "User not signed in" }, status: :unauthorized
    end
  end
end
