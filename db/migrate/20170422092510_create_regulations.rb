class CreateRegulations < ActiveRecord::Migration[5.0]
  def change
    create_table :regulations do |t|
      t.text :regulations

      t.timestamps
    end
  end
end
