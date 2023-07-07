class CreatePaymentsPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments_payments do |t|

      t.timestamps
    end
  end
end
