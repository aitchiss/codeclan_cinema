require('pry')
require('PG')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')
require_relative('./db/sql_runner.rb')


customer1 = Customer.new({
  'name' => "Suzanne",
  'funds' => 45.00
  })

customer1.save

film1 = Film.new({
  'title' => 'Mighty Ducks',
  'price' => 6.50
  })

film1.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket1.save

binding.pry
nil