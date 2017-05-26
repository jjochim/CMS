require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '30s' do
  Rails.logger.info 'Movie front side'
  $movie_front_side = Seance.seven_days_from_now.map{|x| x.movie.id}.uniq
  Rails.logger.info $movie_front_side
end

# scheduler.every '30s' do
#   Approved.all.each do |x|
#     order = Order.find(x.order_id)
#     time = order.created_at + 10.minutes
#     app = order.approved
#     if Time.now > time
#       if not app
#         Rails.logger.info "Usunieto:"
#         Rails.logger.info ap order
#         order.destroy
#         x.delete
#       else
#         Rails.logger.info "Usunieto z app:"
#         Rails.logger.info ap order
#         x.delete
#       end
#     end
#   end
# end