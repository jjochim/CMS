require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '5m' do
  Rails.logger.info 'Movie front side'
  $movie_front_side = Seance.seven_days_from_now.map{|x| x.movie.id}.uniq
  Rails.logger.info $movie_front_side
end
