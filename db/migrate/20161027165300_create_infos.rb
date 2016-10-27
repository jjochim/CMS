class CreateInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :infos do |t|
      t.string :street
      t.string :email
      t.string :phone
      t.string :city
      t.string :zip_code
      t.string :description
      t.string :google_url
      t.string :cinema_name
      t.string :building_number

      t.timestamps
    end
  end
end
