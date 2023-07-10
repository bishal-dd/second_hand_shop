# frozen_string_literal: true

module Common
  def render_resources(resource)
    if resource.errors.empty?
      render json: { status: "success", data: resource}
    else
      render json: { status: "error", errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
