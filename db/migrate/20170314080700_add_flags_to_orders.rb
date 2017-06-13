class AddFlagsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :approved, :boolean
    add_column :orders, :paypal, :boolean
    add_column :orders, :reserved, :boolean
    add_column :orders, :list_seats, :string
    add_column :orders, :activation_code, :string
  end
end
