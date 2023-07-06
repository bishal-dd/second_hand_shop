class Products::ProductSizes < ApplicationRecord
  self.table_name = 'product_sizes'
  has_many :products
end
