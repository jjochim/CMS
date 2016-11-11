class Movie < ApplicationRecord
  mount_uploader :picture, PictureUploader
  has_one :seance
  has_many :category_movies, dependent: :destroy
  has_many :categories, through: :category_movies
  self.per_page = 12
end
