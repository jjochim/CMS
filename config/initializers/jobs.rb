require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '30s' do
  Rails.logger.info 'Movie front side'
  seances = Seance.seven_days_from_now
  Rails.logger.info seances.count
  $movie_front_side = seances.map{|x| x.movie.id}.uniq
  $seance_front_side = seances.map{ |x| x.id }
  Rails.logger.info $movie_front_side
  Rails.logger.info $movie_front_side.size
  Rails.logger.info $seance_front_side
  Rails.logger.info $seance_front_side.size
end

scheduler.every '30s' do
  Approved.all.each do |x|
    order = Order.find(x.order_id)
    time = order.created_at + 10.minutes
    app = order.approved
    if Time.now > time
      if not app
        Rails.logger.info "Usunieto:"
        Rails.logger.info ap order
        order.destroy
        x.delete
      else
        Rails.logger.info "Usunieto z app:"
        Rails.logger.info ap order
        x.delete
      end
    end
  end
end

scheduler.every '1m' do
  t = Time.now
  seances = Seance.where(start_date: (t - 15.minutes)..(t)).map{ |x| x.id }
  Order.where(seance_id: seances, reserved: true, paid: false).each do |x|
    Rails.logger.info x.id
    x.delete
  end
end