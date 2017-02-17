class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_f
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING * ;"
    customer_details = SqlRunner.run(sql)
    customer_hash = customer_details[0]
    @id = customer_hash['id'].to_i
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds}) WHERE id = #{@id} ;"
    SqlRunner.run(sql)
  end

  def tickets()
    sql = "SELECT * FROM tickets WHERE customer_id = #{@id};"
    return Ticket.get_many(sql)
  end

  def count_tickets()
    return tickets.count
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN
          tickets ON tickets.film_id = films.id
          WHERE tickets.customer_id = #{@id} ;"
    return Film.get_many(sql)
  end


  def self.all()
    sql = "SELECT * FROM customers;"
    customers = Customer.get_many(sql)
    return customers
  end

  def self.find(id)
    sql = "SELECT * FROM customers WHERE id = #{id};"
    customers_details = SqlRunner.run(sql)
    customer = customers_details[0]
    return Customer.new(customer)
  end

  def self.get_many(sql)
    customers_details = SqlRunner.run(sql)
    return customers_details.map { |customer| Customer.new(customer) }
  
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

end