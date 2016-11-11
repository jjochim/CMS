class Category < ApplicationRecord
  has_many :category_movies, dependent: :destroy
  has_many :movies, through: :category_movies
end
