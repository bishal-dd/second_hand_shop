class Products::ProductCategories < ApplicationRecord
  self.table_name = 'product_categories'
  has_many :products
end
