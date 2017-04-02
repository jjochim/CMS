class Room < ApplicationRecord
  has_many :seances
  has_many :seatings, dependent: :destroy
  self.per_page = 20
end
