require ('minitest/autorun')
require('pg')
require_relative ('../models/customer.rb')
require_relative('../models/film.rb')
require_relative('../models/ticket.rb')
require_relative('../db/sql_runner.rb')

class TestCustomer < MiniTest::Test

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
      'film_id' => @film1.id,
      'time' => "20:30"
      })
    @ticket1.save

    @ticket2 = Ticket.new({
      'customer_id' => @customer2.id,
      'film_id' => @film2.id,
      'time' => "19:30"
      })
    @ticket2.save

    @ticket3 = Ticket.new({
      'customer_id' => @customer1.id,
      'film_id' => @film2.id,
      'time' => "19:30"
      })
    @ticket3.save

    @ticket4 = Ticket.new({
      'customer_id' => @customer2.id,
      'film_id' => @film2.id,
      'time' => "21:00"

      })
  end

  def test_counts_number_of_tickets_for_customer
    assert_equal(2, @customer1.count_tickets)
  end

  def test_ticket_count_works_for_added_tickets
    @ticket2.customer_id = @customer1.id
    @ticket2.update
    assert_equal(3, @customer1.count_tickets)
  end

  def test_count_films
    assert_equal(2, @customer1.count_films)
  end

  def test_buy_ticket
    @customer1.buy_ticket(@film1)
    assert_equal(3, @customer1.count_tickets)
  end

  def test_buy_ticket_decreases_funds
    @customer1.buy_ticket(@film1)
    assert_equal(38.5, @customer1.funds)
  end

  def test_buy_ticket_increases_tickets_sold
    @customer1.buy_ticket(@film1)
    assert_equal(2, @film1.count_tickets)
  end

 

end