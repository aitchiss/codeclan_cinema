require('pry')
require('PG')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
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

binding.pry
nil