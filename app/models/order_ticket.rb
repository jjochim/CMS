class OrderTicket < ApplicationRecord
  belongs_to :ticket
  belongs_to :order
end
