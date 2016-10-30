class OrderSeating < ApplicationRecord
  belongs_to :seating
  belongs_to :order
  self.per_page = 20
end
