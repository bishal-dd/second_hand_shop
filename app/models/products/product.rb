class Products::Product < ApplicationRecord
  self.table_name = "products"
  has_one_attached :image
  attr_accessor :image_url
  has_one :payment
  belongs_to :product_category, class_name: 'Products::ProductCategory', foreign_key: 'product_categories_id'
  belongs_to :product_size, class_name: 'Products::ProductSize', foreign_key: 'product_sizes_id'
end