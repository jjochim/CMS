class CreateOrderSeatings < ActiveRecord::Migration[5.0]
  def change
    create_table :order_seatings do |t|
      t.integer :seating_id
      t.integer :order_id

      t.timestamps
    end
  end
end
