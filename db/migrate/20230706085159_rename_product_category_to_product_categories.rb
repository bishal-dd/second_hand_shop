class RenameProductCategoryToProductCategories < ActiveRecord::Migration[7.0]
  def change
    rename_table :product_categories, :product_categories
  end
end
