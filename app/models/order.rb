class Order < ApplicationRecord
  belongs_to :seancse
  has_many :order_seatings, dependent: :destroy
  has_many :seatings, through: :order_seatings
  has_many :order_tickets, dependent: :destroy
  has_many :tickets, through: :order_tickets
  validates_presence_of [:name, :surname, :email, :seance_id]

  self.per_page = 20
end
