require ('minitest/autorun')
require('pg')
require_relative ('../models/customer.rb')
require_relative('../models/film.rb')
require_relative('../models/ticket.rb')
require_relative('../db/sql_runner.rb')

class TestFilm < MiniTest::Test

  def setup()

    Customer.delete_all
    Film.delete_all
    Ticket.delete_all

    @customer1 = Customer.new({
      'name' => "Suzanne",
      'funds' => 45.00
      })
    @customer1.save

    @customer2 = Customer.new({
      'name' => "Colin",
      'funds' => 20.00
      })
    @customer2.save

    @customer3 = Customer.new({
      'name' => "David",
      'funds' => 10.00
      })
    @customer3.save

    @film1 = Film.new({
      'title' => 'Mighty Ducks',
      'price' => 6.50
      })
    @film1.save

    @film2 = Film.new({
      'title' => 'Young Guns',
      'price' => 5.50
      })
    @film2.save

    @ticket1 = Ticket.new({
      'customer_id' => @customer1.id,
      'film_id' => @film1.id
      })
    @ticket1.save

    @ticket2 = Ticket.new({
      'customer_id' => @customer2.id,
      'film_id' => @film2.id
      })
    @ticket2.save

    @ticket3 = Ticket.new({
      'customer_id' => @customer1.id,
      'film_id' => @film2.id
      })
    @ticket3.save
  end

  def test_count_tickets
    assert_equal(2, @film2.count_tickets)
  end

  def test_count_tickets_increments_for_new_tickets
    @ticket1.film_id = @film2.id
    @ticket1.update
    assert_equal(3, @film2.count_tickets)
  end

  def test_count_customers
    assert_equal(2, @film2.count_customers)
  end

  def test_count_customers_increments_for_new_customers
    @ticket4 = Ticket.new({
      'customer_id' => @customer3.id,
      'film_id' => @film2.id
      })
    @ticket4.save
    assert_equal(3, @film2.count_customers)
  end



end