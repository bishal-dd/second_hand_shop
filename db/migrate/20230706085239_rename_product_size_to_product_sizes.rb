class RenameProductSizeToProductSizes < ActiveRecord::Migration[7.0]
  def change
    rename_table :product_sizes, :product_sizes
  end
end
