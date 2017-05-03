module ApplicationHelper
  def format_date(time)
    time.strftime("%Y-%m-%d")
  end

  def date_for_gteq(q)
    return "" if q.blank?
    q[:start_date_gteq].blank? ? "" : format_date(q[:start_date_gteq].to_date)
  end

  def background_check(controller, action)
    back_class = "background "
    return back_class.concat("background-2") if controller == "orders" && action == "show_room"
    back_class.concat("background-1")
  end

  def admin_class
    "admin-class" if current_user and current_user.role == 'admin'
  end

  def date_for_lteq(q)
    return "" if q.blank?
    q[:start_date_lteq].blank? ? "" : format_date(q[:start_date_lteq].to_date)
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
    if seance.threed
      tmp = ' 3D'
    else
      tmp = ' 2D'
    end
    return tmp
  end

  def threed_trueorfalse(seance)
    if seance.threed
      tmp = 'TAK'
    else
      tmp = 'NIE'
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
