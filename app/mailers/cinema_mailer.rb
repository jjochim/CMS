class CinemaMailer < ApplicationMailer
  def test_mailer(email)
    tmp = mail(
        to: email,
        subject: 'testowy_mail',
        from: 'cinema.managment.system@gmail.com',
        return_path: 'cinema.managment.system@gmail.com'
    ) do |format|
      format.text
      format.html
    end
    tmp.deliver
  end

  def info_for_user(order,num)
    @order = order
    @info = Info.last
    room = order.seance.room
    @seats = num
    @room = room.name

    tmp = mail(
        to: order.email,
        subject: 'Rezerwacja biletu',
        from: 'cinema.managment.system@gmail.com',
        return_path: 'cinema.managment.system@gmail.com'
    ) do |format|
      format.html
      format.text
    end
    tmp.deliver
  end

  def confirm(order)
    @order = order
    @seance_name = @order.seance.movie.title
    @info = Info.last

    tmp = mail(
        to: order.email,
        subject: 'Potwierdzenie rezerwacji',
        from: 'cinema.managment.system@gmail.com',
        return_path: 'cinema.managment.system@gmail.com'
    ) do |format|
      format.html
      format.text
    end
    tmp.deliver
  end

  def sale(order)
    @order = order
    @info = Info.last
    room = order.seance.room
    @room = room.name

    tmp = mail(
        to: order.email,
        subject: 'Transakcja zakończona sukcesem',
        from: 'cinema.managment.system@gmail.com',
        return_path: 'cinema.managment.system@gmail.com'
    ) do |format|
      format.html
      format.text
    end
    tmp.deliver
  end
end
