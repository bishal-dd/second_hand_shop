class Payment < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.decimal :amount
    end
  end
end
