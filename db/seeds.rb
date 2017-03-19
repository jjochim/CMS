# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create name: 'Janusz', last_name: 'Joc', email: 'janusz.jochim@gmail.com', phone: '123456789', password: 'zaq12wsx', password_confirmation: 'zaq12wsx', role: 'admin'
u2 = User.create name: 'Jan', last_name: 'Joc', email: 'evo670@wp.pl', phone: '123456789', password: 'zaq12wsx', password_confirmation: 'zaq12wsx', role: 'employee'

Info.create(cinema_name: 'Kino', street: 'ulica', email: 'email@email.com', phone: '7356252783', city: 'Miasto', zip_code: '68-273',
            description: 'Lorem Ipsum jest tekstem stosowanym jako przykładowy wypełniacz w przemyśle poligraficznym. Został po raz pierwszy użyty w XV w. przez nieznanego drukarza do wypełnienia tekstem próbnej książki. Pięć wieków później zaczął być używany przemyśle elektronicznym, pozostając praktycznie niezmienionym. Spopularyzował się w latach 60. XX w. wraz z publikacją arkuszy Letrasetu, zawierających fragmenty Lorem Ipsum, a ostatnio z zawierającym różne wersje Lorem Ipsum oprogramowaniem przeznaczonym do realizacji druków na komputerach osobistych, jak Aldus PageMaker',
            google_url: "https://ww")

puts 'Kategorie '
Category.create(name: 'Premiera')
Category.create(name: 'Komedia')
Category.create(name: 'Horror')
Category.create(name: 'Akcja')
Category.create(name: 'Dramat')
puts

print 'Movie '
0.upto(15) do |indx|
  tmp = Movie.create(
      title: 'Movie_' + indx.to_s,
      duration: 60 + indx,
      pegi: [3, 10, 18].shuffle.first,
      description: (0...50).map { ('a'..'z').to_a[rand(26)] }.join,
      director: 'director_' + indx.to_s,
      actors: 'actor_' + indx.to_s,
      country: ['PL', 'UK', 'DE'].shuffle.first,
      premiere: Time.now - 10.days + indx.days,
      url_trailer: 'https://www.youtube.com/embed/hvchSr3Myfg',
      language: ['polish', 'german', 'english'].shuffle.first
  )
  tmp.categories << Category.all.shuffle.first
  print '. '
end
puts

print 'Room + seatings '
0.upto(2) do |indx|
  rows, columns = [[10, 10] , [6, 10] , [12, 24]].shuffle.first
  Room.create(rows: rows, columns: columns, name: 'Room_' + indx.to_s)
  (0...(rows * columns)).each do |indx0|
    Seating.create(slot: [true, false].shuffle.first, room_id: Room.last.id)
  end
  print '. '
end
puts

print 'Tickets'
Ticket.create(name: 'ulgowy', price: '10')
Ticket.create(name: 'normalny', price: '20')
Ticket.create(name: 'studencki', price: '15')
puts

print 'Seance '
0.upto(4) do |indx|
  10.upto(24) do |index|
    0.upto(10) do
      print '. '
      Seance.create(room: Room.all.shuffle.first, movie: Movie.all.shuffle.first, start_date: Time.now + indx.days + index.hours,
                    threed: [true, false].shuffle.first, dubbing: true)
    end
  end
end
puts


