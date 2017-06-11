class Seance < ApplicationRecord
  belongs_to :room
  belongs_to :movie
  has_many :orders
  
  validates_presence_of [:movie, :room, :start_date]
  validate :check_seances

  self.per_page = 12
  scope :seven_days_from_now, -> {where start_date: (Time.now)..(6.days.from_now.end_of_day) }


  private
  def check_seances
    room = self.room
    time_tested = (self.start_date.to_i..(self.start_date + self.movie.duration.minutes).to_i).to_a

    seances = Seance.where(room_id: room.id).where.not(id: self.id)

    seances.each do |seans|
      if time_tested.include?(seans.start_date.to_i) or
          time_tested.include?((seans.start_date + seans.movie.duration.minutes).to_i) or
          self.start_date.to_i.between?(seans.start_date.to_i, seans.movie.duration.minutes.to_i)
        errors.add(:start_date, 'Seanse się nakładają!')
      end
    end
  end
end
