class Seance < ApplicationRecord
  belongs_to :room
  belongs_to :movie
  has_many :orders
  validates_presence_of [:movie, :room, :start_date]
  # validate :validate_room_and_date
  self.per_page = 12
  scope :seven_days_from_now, -> {where start_date: (Time.now + 15.minutes)..(6.days.from_now.end_of_day) }


  private
  def validate_room_and_date
    if Seance.where(:start_date => start_date..start_date+(Movie.where(id: movie_id).first.duration).minutes).where(room_id: room_id).blank?
      errors.add(:start_date, "Nie mozna utowrzyc, bo filmy sie bedo nakladac")
    end
    if Seance.where(:start_date => start_date-(Movie.where(id: movie_id).first.duration).minutes..start_date).where(room_id: room_id).blank?
      errors.add(:start_date, "W tym czasie trwa jeszcze jakis film na tej sali")
    end
  end
end
