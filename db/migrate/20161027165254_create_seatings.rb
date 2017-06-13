class CreateSeatings < ActiveRecord::Migration[5.0]
  def change
    create_table :seatings do |t|
      t.boolean :slot
      t.integer :room_id

      t.timestamps
    end
  end
end
