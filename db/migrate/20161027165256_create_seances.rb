class CreateSeances < ActiveRecord::Migration[5.0]
  def change
    create_table :seances do |t|
      t.datetime :start_date
      t.integer :movie_id
      t.integer :room_id
      t.boolean :threed
      t.boolean :lector
      t.boolean :subtitle
      t.boolean :dubbing

      t.timestamps
    end
  end
end
