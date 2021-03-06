class Film

  attr_accessor :title, :price, :max_tickets
  attr_reader :id

  def initialize ( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_f
    @max_tickets = options['max_tickets'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price, max_tickets) VALUES ('#{@title}', #{@price}, #{@max_tickets}) RETURNING * ;"
    film_details = SqlRunner.run(sql)
    film_hash = film_details[0]
    @id = film_hash['id'].to_i
  end

  def delete()
    sql = "DELETE FROM films WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE films SET (title, price, max_tickets) = ('#{@title}', #{@price}, #{@max_tickets}) WHERE id = #{@id}; "
    SqlRunner.run(sql)
  end

  def times()
    sql = "SELECT * FROM tickets WHERE film_id = #{@id};"
    tickets = Ticket.get_many(sql)
    times = []
    tickets.each { |ticket| times << ticket.time }
    return times.uniq
  end

  def busiest_screening_time()
    sql = "SELECT * FROM tickets WHERE film_id = #{@id} GROUP BY time, tickets.id ORDER BY COUNT(*) DESC LIMIT 1;"
    result = SqlRunner.run(sql)
    ticket = Ticket.new(result[0])
    return ticket.time
  end

  def tickets()
    sql = "SELECT * FROM tickets WHERE film_id = #{@id};"
    tickets = Ticket.get_many(sql)
    return tickets
  end

  def count_tickets()
    return tickets.count
  end

  def tickets_by_time(time)
    time.gsub!(".", ":") if time.include?(".")
    time << ":00" unless time.include?(":")
    sql = "SELECT * FROM tickets where film_id = #{@id} AND time = '#{time}';"
    tickets = Ticket.get_many(sql)
    return tickets
  end

  def count_tickets_by_time(time)
    return tickets_by_time(time).count
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN
          tickets ON tickets.customer_id = customers.id
          WHERE tickets.film_id = #{@id}; "
    return Customer.get_many(sql)
  end

  def count_customers()
    return customers.count
  end


  def self.all()
    sql = "SELECT * FROM films;"
    films = Film.get_many(sql)
    return films
  end

  def self.find(id)
    sql = "SELECT * FROM films WHERE id = #{id};"
    film_details = SqlRunner.run(sql)
    film_hash = film_details[0]
    return Film.new(film_hash)
  end


  def self.get_many(sql)
    films_details = SqlRunner.run(sql)
    return films_details.map { |film| Film.new(film) }
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

end