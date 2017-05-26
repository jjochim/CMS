# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create name: 'Admin', last_name: 'Admin', email: ENV["admin_email"], phone: '123456789', password: ENV["admin_password"], password_confirmation: ENV["admin_password"], role: 'admin'
u2 = User.create name: 'Jan', last_name: 'Joc', email: 'evo670@wp.pl', phone: '123456789', password: 'zaq12wsx', password_confirmation: 'zaq12wsx', role: 'employee'

# Info.create(cinema_name: 'Kino', street: 'ulica', email: 'email@email.com', phone: '7356252783', city: 'Miasto', zip_code: '68-273',
#             description: 'Lorem Ipsum jest tekstem stosowanym jako przykładowy wypełniacz w przemyśle poligraficznym. Został po raz pierwszy użyty w XV w. przez nieznanego drukarza do wypełnienia tekstem próbnej książki. Pięć wieków później zaczął być używany przemyśle elektronicznym, pozostając praktycznie niezmienionym. Spopularyzował się w latach 60. XX w. wraz z publikacją arkuszy Letrasetu, zawierających fragmenty Lorem Ipsum, a ostatnio z zawierającym różne wersje Lorem Ipsum oprogramowaniem przeznaczonym do realizacji druków na komputerach osobistych, jak Aldus PageMaker',
#             google_url: "https://ww")

puts 'Kategorie '
Category.create(name: 'Premiera')
Category.create(name: 'Komedia')
Category.create(name: 'Horror')
Category.create(name: 'Akcja')
Category.create(name: 'Dramat')
Category.create(name: 'Kryminał')
Category.create(name: 'Musical')
Category.create(name: 'Sci-fi')
Category.create(name: 'Dokumentalny')
puts

print 'Movie '
1.upto(15) do |indx|
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
      language: ['polish', 'german', 'english'].shuffle.first,
      picture: File.open(File.join(Rails.root, "/public/uploads/movie/picture/photo/#{indx}.jpg"))
  )
  tmp.categories << Category.all.shuffle.first
  print '. '
end
puts

# print 'Room + seatings '
# 0.upto(2) do |indx|
#   rows, columns = [[10, 10] , [6, 10] , [12, 24]].shuffle.first
#   Room.create(rows: rows, columns: columns, name: 'Room_' + indx.to_s)
#   (0...(rows * columns)).each do |indx0|
#     Seating.create(slot: [true, false].shuffle.first, room_id: Room.last.id)
#   end
#   print '. '
# end
# puts

print 'Tickets'
Ticket.create(name: 'ulgowy', price: '10')
Ticket.create(name: 'normalny', price: '20')
Ticket.create(name: 'studencki', price: '15')
puts

Movie.create!([
  {title: "Logan: Wolverine ", duration: 137, pegi: 12, description: "Tracący moc Logan staje się mentorem małej dziewczynki, która posiada podobne zdolności.", director: "James Mangold", actors: "Hugh Jackman, Patrick Stewart, Dafne Keen", country: "USA", language: nil, premiere: "2017-04-09 22:00:00", url_trailer: "https://www.youtube.com/embed/Div0iP65aZo", picture: "logan.jpg"}
])
Room.create!([
  {rows: 10, columns: 16, name: "Sala 1"},
  {rows: 5, columns: 10, name: "Sala 2"},
  {rows: 20, columns: 36, name: "Sala 3"}
])
Seating.create!([
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: false, room_id: 1},
  {slot: false, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 1},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: true, room_id: 2},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: false, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3},
  {slot: true, room_id: 3}
])

print 'Seance '
0.upto(8) do |indx|
  10.upto(22) do |index|
    0.upto(10) do
      if index % 2 == 0
        print '. '
        Seance.create(room: Room.all.shuffle.first, movie: Movie.all.shuffle.first, start_date: Time.now + indx.days + index.hours,
                      threed: [true, false].shuffle.first, dubbing: true, block: false)
      end
    end
  end
end
puts

# Seance.create!([
#   {start_date: "2017-04-16 13:06:00", movie_id: 1, room_id: 1, threed: true, lector: true, subtitle: false, dubbing: false},
#   {start_date: "2017-04-16 04:07:00", movie_id: 1, room_id: 2, threed: false, lector: false, subtitle: true, dubbing: false}
# ])
# Order.create!([
#   {name: "dasdas", surname: "fdssad", email: "adfasda@da.pl", phone: "", seance_id: 2, paid: false, approved: true, paypal: false, reserved: true, list_seats: "1E,2E"},
#   {name: "sad", surname: "qq", email: "wqw@pl.pl", phone: "", seance_id: 2, paid: false, approved: true, paypal: false, reserved: true, list_seats: "3E,4E"},
#   {name: "wqwqwq", surname: "reert", email: "iii@pl.pl", phone: "", seance_id: 2, paid: false, approved: true, paypal: false, reserved: true, list_seats: "10E,9E"}
# ])
# OrderSeating.create!([
#   {seating_id: 201, order_id: 1},
#   {seating_id: 202, order_id: 1},
#   {seating_id: 203, order_id: 2},
#   {seating_id: 204, order_id: 2},
#   {seating_id: 210, order_id: 3},
#   {seating_id: 209, order_id: 3}
# ])
Info.create!([
  {street: "ulica", email: "email@email.com", phone: "7356252783", city: "Miasto", zip_code: "68-273", description: "Lorem Ipsum jest tekstem stosowanym jako przykładowy wypełniacz w przemyśle poligraficznym. Został po raz pierwszy użyty w XV w. przez nieznanego drukarza do wypełnienia tekstem próbnej książki. Pięć wieków później zaczął być używany przemyśle elektronicznym, pozostając praktycznie niezmienionym. Spopularyzował się w latach 60. XX w. wraz z publikacją arkuszy Letrasetu, zawierających fragmenty Lorem Ipsum, a ostatnio z zawierającym różne wersje Lorem Ipsum oprogramowaniem przeznaczonym do realizacji druków na komputerach osobistych, jak Aldus PageMaker", google_url: "https://wws", cinema_name: "Kino", building_number: "", start_mon: "2017-04-19 08:00:00", start_tue: "2017-04-19 08:00:00", start_wed: "2017-04-19 09:00:00", start_thu: "2017-04-19 08:00:00", start_fri: "2017-04-19 08:00:00", start_sat: "2017-04-19 10:00:00", start_sun: "2017-04-19 10:00:00", end_mon: "2017-04-19 18:00:00", end_tue: "2017-04-19 18:00:00", end_wed: "2017-04-19 18:00:00", end_thu: "2017-04-19 18:00:00", end_fri: "2017-04-19 20:00:00", end_sat: "2017-04-19 21:40:00", end_sun: "2017-04-19 21:40:00"}
])
Regulation.create!([
  {regulations: "<b>Witaj w CMS!</b>"},
])
