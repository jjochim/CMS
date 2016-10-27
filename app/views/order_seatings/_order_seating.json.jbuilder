json.extract! order_seating, :id, :seating_id, :order_id, :ticked_id, :created_at, :updated_at
json.url order_seating_url(order_seating, format: :json)