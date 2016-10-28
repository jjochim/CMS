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
    room = order.seanse.room
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
end
