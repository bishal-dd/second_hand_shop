class Products::Products < ApplicationRecord
  self.table_name = "products"
  belongs_to :product_categories
  belongs_to :product_sizes

end
