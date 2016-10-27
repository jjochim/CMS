json.extract! order, :id, :name, :surname, :email, :phone, :seance_id, :paid, :created_at, :updated_at
json.url order_url(order, format: :json)