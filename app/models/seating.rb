class Seating < ApplicationRecord
  belongs_to :room
  has_many :order_seatings
  has_many :orders, through:  :order_seatings
end
