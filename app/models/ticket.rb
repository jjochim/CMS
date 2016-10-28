class Ticket < ApplicationRecord
  has_many :order_tickets
  has_many :orders, through: :order_tickets
end
