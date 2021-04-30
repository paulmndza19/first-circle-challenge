class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.text :customer_address
      t.decimal :total_price

      t.timestamps
    end
  end
end
