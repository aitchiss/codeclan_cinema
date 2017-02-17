require('pry')
require('PG')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')
require_relative('./db/sql_runner.rb')

Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new({
  'name' => "Suzanne",
  'funds' => 45.00
  })

customer1.save

customer2 = Customer.new({
  'name' => "Colin",
  'funds' => 20.00
  })

customer2.save

film1 = Film.new({
  'title' => 'Mighty Ducks',
  'price' => 6.50
  })

film1.save

film2 = Film.new({
  'title' => 'Young Guns',
  'price' => 5.50
  })

film2.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket1.save

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
  })

ticket2.save

binding.pry
nil