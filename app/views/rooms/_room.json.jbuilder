json.extract! room, :id, :rows, :columns, :name, :created_at, :updated_at
json.url room_url(room, format: :json)