class Account < ApplicationRecord
  has_one_attached :image
  attr_accessor :image_url

end
