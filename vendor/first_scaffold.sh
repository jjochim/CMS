rails g scaffold Movie title duration:integer genre pegi:integer description director actors country language premiere:datetime url_trailer picture
rails g scaffold Category name
rails g scaffold CategoryMovie category_id:integer movie_id:integer
rails g scaffold Room rows:integer columns:integer name
rails g scaffold Seating slot:boolean room_id:integer
rails g scaffold Order name surname email phone seance_id:integer paid:boolean
rails g scaffold Seance start_date:datetime movie_id:integer room_id:integer threed:boolean lector:boolean subtitle:boolean dubbing:boolean
rails g scaffold Ticket name price:float
rails g scaffold OrderSeating seating_id:integer order_id:integer ticked_id:integer
rails g scaffold OrderTicket order_id:integer ticked_id:integer
rails g scaffold Info street email phone city zip_code description google_url cinema_name building_number
