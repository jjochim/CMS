json.extract! order_ticket, :id, :order_id, :ticked_id, :created_at, :updated_at
json.url order_ticket_url(order_ticket, format: :json)