module ApplicationHelper
  def format_date(time)
    time.strftime("%d-%m-%Y")
  end

  def format_time(time)
    time.strftime("%H:%M")
  end

  def format_datatime(time)
    time.strftime("%d-%m-%Y %H:%M")
  end

  def day_of_week(day)
    days = ['Niedziela', 'Poniedziałek', 'Wtorek', 'Środa', 'Czwartek', 'Piątek', 'Sobota']
    days[day]
  end

  def month_of_year(month)
    months = ['Stycznia', 'Lutego', 'Marca', 'Kwietnia', 'Maja', 'Czerwca', 'Lipca', 'Sierpnia', 'Września', 'Października', 'Listopada', 'Grudnia']
    months[month]
  end

  def format_date_for_seance(day)
    format = [day_of_week(day.strftime("%w").to_i), day.strftime("%d"), month_of_year(day.strftime("%m").to_i - 1), day.strftime("%Y")]
  end

  def cinema_name
    Info.last.cinema_name
  end

  def seats_count(seance)
    b=[]
    seance.orders.map { |x| x.seatings x }.each { |seats| seats.each {|y| b << y.id}}
    b.length
  end

  def threed_check(seance)
    tmp = ''
    if seance.threed
      tmp = ' 3D'
    else
      tmp = ' 2D'
    end
    return tmp
  end

  def subtitle_check(seance)
    tmp = ''
    if seance.subtitle
      tmp = 'Napisy'
    elsif seance.lector
      tmp = 'Lektor'
    else
      tmp = 'Dubbing'
    end
    return tmp
  end
end
