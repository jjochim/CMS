class Room < ApplicationRecord
  has_one :seance
  has_many :seatings, dependent: :destroy
  self.per_page = 20
end
