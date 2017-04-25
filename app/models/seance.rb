class Seance < ApplicationRecord
  belongs_to :room
  belongs_to :movie
  has_many :orders
  validates_presence_of [:movie, :room, :start_date]
  validate :nie_zrobisz_se_seansa
  self.per_page = 12
  scope :seven_days_from_now, -> {where start_date: (Time.now + 15.minutes)..(6.days.from_now.end_of_day) }


  private
  def nie_zrobisz_se_seansa
    sala = self.room
    zakres = (self.start_date.to_i..(self.start_date + self.movie.duration.minutes).to_i).to_a

    wszystkie_seansy = Seance.where(room_id: sala.id)

    wszystkie_seansy.each do |seans|
      if zakres.include?(seans.start_date.to_i) or
          zakres.include?((seans.start_date + seans.movie.duration.minutes).to_i) or
          self.start_date.to_i.between?(seans.start_date.to_i, seans.movie.duration.minutes.to_i)
        errors.add(:start_date, 'Seanse się nakładają!')
      end
    end
  end
end
