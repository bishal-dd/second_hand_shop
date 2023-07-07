class Products::Products < ApplicationRecord
  self.table_name = "products"
  has_one_attached :image
  attr_accessor :image_url
  has_one :payment
  belongs_to :product_categories, class_name: 'Products::ProductCategories', foreign_key: 'product_categories_id'
  belongs_to :product_sizes, class_name: 'Products::ProductSizes', foreign_key: 'product_sizes_id'
end