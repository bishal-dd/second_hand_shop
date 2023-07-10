# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(email: "john@example.com")
    expect(user).to be_valid
  end

  it "is not valid without a email" do
    user = User.new(email: "john@example.com")
    expect(user).to_not be_valid
  end

  # Add more tests as needed...
end


