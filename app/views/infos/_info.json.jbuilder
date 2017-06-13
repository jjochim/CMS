json.extract! info, :id, :street, :email, :phone, :city, :zip_code, :description, :google_url, :cinema_name, :building_number, :created_at, :updated_at
json.url info_url(info, format: :json)