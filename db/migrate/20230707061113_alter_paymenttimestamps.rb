class AlterPaymenttimestamps < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :created_at, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :payments, :updated_at, :datetime, null: false, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
