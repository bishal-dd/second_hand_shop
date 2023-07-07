class Products::ProductCategory < ApplicationRecord
  self.table_name = 'product_categories'
  has_many :product
end
