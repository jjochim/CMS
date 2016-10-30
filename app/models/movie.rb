class Movie < ApplicationRecord
  mount_uploader :picture, PictureUploader
  has_one :seanse
  has_many :category_movies
  has_many :categories, through: :category_movies
  self.per_page = 12
end
