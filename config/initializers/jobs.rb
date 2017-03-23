require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '5m' do
  Rails.logger.info 'Movie front side'
  $movie_front_side = Seance.seven_days_from_now.map{|x| x.movie.id}.uniq
  Rails.logger.info $movie_front_side
end

scheduler.every '5s' do
  # if $checked_approved.length > 0
  #   $checked_approved.each do |order|
      time = Order.find(1).created_at
      Rails.logger.info 'dsadnjansdfljknadsflnasdlfnmlasdnfmlsnagfdjn;kaljsfndgb;kljsfnbg;kjansfdgkjnasfdkjngfasdkjn'
      Rails.logger.info time
      Rails.logger.info Time.now
      Rails.logger.info $checked_approved
      # if  time
      #
      # end
    # end
  # end
end