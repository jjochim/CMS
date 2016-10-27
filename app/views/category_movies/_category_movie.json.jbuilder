json.extract! category_movie, :id, :category_id, :movie_id, :created_at, :updated_at
json.url category_movie_url(category_movie, format: :json)