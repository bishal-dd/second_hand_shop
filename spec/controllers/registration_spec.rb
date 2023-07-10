# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) do
        {
          user: {
            email: "test@example.com",
            password: "password",
            password_confirmation: "password"
          }
        }
      end

      it "creates a new user" do
        expect do
          post :create, params: valid_params
        end.to change(User, :count).by(1)
      end

      it "sets the role as 'user'" do
        post :create, params: valid_params
        user = User.last
        expect(user.role).to eq("user")
      end

      it "returns a JSON response with the created user" do
        post :create, params: valid_params
        user = User.last
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to eq(user.to_json)
      end
    end

    context "with invalid params" do
      let(:invalid_params) do
        {
          user: {
            email: "test@example.com",
            password: "password",
            password_confirmation: "wrong_password"
          }
        }
      end

      it "does not create a new user" do
        expect do
          post :create, params: invalid_params
        end.to_not change(User, :count)
      end

      it "returns a JSON response with errors" do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to include("Password confirmation doesn't match Password")
      end
    end
  end
end


