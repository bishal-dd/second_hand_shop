class AlterProductsTable < ActiveRecord::Migration[7.0]
  def up
    change_column :products, :status, :integer, using: 'status::integer', default: 0, null: false
  end

  def down
    change_column :products, :status, :string
  end
end
