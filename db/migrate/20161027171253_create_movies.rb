class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :duration
      t.string :genre
      t.integer :pegi
      t.string :description
      t.string :director
      t.string :actors
      t.string :country
      t.string :language
      t.datetime :premiere
      t.string :url_trailer
      t.string :picture

      t.timestamps
    end
  end
end
