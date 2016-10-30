class CreateOrderTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :order_tickets do |t|
      t.integer :order_id
      t.integer :ticked_id

      t.timestamps
    end
  end
end
