class CreateCategoryMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :category_movies do |t|
      t.integer :category_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
