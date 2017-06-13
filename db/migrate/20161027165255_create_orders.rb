class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :phone
      t.integer :seance_id
      t.boolean :paid

      t.timestamps
    end
  end
end
