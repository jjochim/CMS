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