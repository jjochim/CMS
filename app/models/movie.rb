class Movie < ApplicationRecord
  mount_uploader :picture, PictureUploader

  has_many :seances
  has_many :category_movies, dependent: :destroy
  has_many :categories, through: :category_movies

  validates :title, :duration, :premiere, :url_trailer, :description, presence: true
  validates :duration, :pegi, numericality: { only_integer: true }
  validates :duration, :pegi, inclusion: { in: 1..1000 }
  self.per_page = 12
end
