class Movie < ApplicationRecord
  mount_uploader :picture, PictureUploader
  has_many :seances
  has_many :category_movies, dependent: :destroy
  has_many :categories, through: :category_movies
  validates :title, :duration, :premiere, :url_trailer, :description, presence: true
  validates :duration, :pegi, numericality: {only_integer: true}
  validates :duration, :pegi, inclusion: {in: 1..1000}
  before_save :generate_friendly_url!, if: :title_changed?
  self.per_page = 12

  after_create :generate_friendly_url!

  def generate_friendly_url!
    tmp = self.title
    translate_map = {
        'ń' => 'n',
        'ą' => 'a',
        'ł' => 'l',
        'ę' => 'e',
        'ć' => 'c',
        'ó' => 'o',
        'ź' => 'z',
        'ż' => 'z',
        'Ń' => 'n',
        'Ą' => 'a',
        'Ł' => 'l',
        'Ę' => 'e',
        'Ć' => 'c',
        'Ó' => 'o',
        'Ź' => 'z',
        'Ż' => 'z',
        /\s/ => '_'
    }

    translate_map.each  do |pl, en|

      tmp = tmp.to_s.gsub(pl, translate_map[pl])
    end
     self.friendly_url = tmp.underscore
  end

  def to_param
    self.generate_friendly_url!
  end

end
