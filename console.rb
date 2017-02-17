require('pry')
require_relative('./models/customer.rb')


customer1 = Customer.new({
  'name' => "Suzanne",
  'funds' => 45.00
  })

binding.pry
nil