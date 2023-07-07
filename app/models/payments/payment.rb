class Payments::Payment < ApplicationRecord
  self.table_name = 'payments'
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :product, class_name: 'Products::Product', foreign_key: 'product_id'

end
