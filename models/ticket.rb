class Ticket

  attr_accessor :customer_id, :film_id
  attr_reader :id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES (#{@customer_id}, #{@film_id}) RETURNING * ;"
    ticket_details = SqlRunner.run(sql)
    ticket_hash = ticket_details[0]
    @id = ticket_hash['id'].to_i
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM tickets WHERE id = #{id};"
    ticket_details = SqlRunner.run(sql)
    ticket_hash = ticket_details[0]
    return Ticket.new(ticket_hash)
  end

  def self.all()
    sql = "SELECT * FROM tickets;"
    tickets = Ticket.get_many(sql)
    return tickets
  end

  def self.get_many(sql)
    tickets_details = SqlRunner.run(sql)
    tickets = tickets_details.map {|ticket| Ticket.new(ticket)}
    return tickets
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

end