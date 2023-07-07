class Alteraccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :jrnl_no,  :integer
  end
end
