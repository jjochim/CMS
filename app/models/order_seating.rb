class OrderSeating < ApplicationRecord
  belongs_to :seating
  belongs_to :order
end
