class Room < ApplicationRecord
  has_many :seances
  has_many :seatings, dependent: :destroy

  validates :name, :rows, :columns, presence: true
  validates :rows, :columns, numericality: { only_integer: true }
  validates :rows, inclusion: { in: 1..26 }
  validates :columns, inclusion: { in: 4..36 }
  self.per_page = 20
end
