json.extract! seance, :id, :start_date, :movie_id, :room_id, :threed, :lector, :subtitle, :dubbing, :created_at, :updated_at
json.url seance_url(seance, format: :json)