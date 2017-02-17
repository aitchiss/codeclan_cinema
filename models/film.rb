class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize ( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_f
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ('#{@title}', #{@price}) RETURNING * ;"
    film_details = SqlRunner.run(sql)
    film_hash = film_details[0]
    @id = film_hash['id'].to_i
  end

  def delete()
    sql = "DELETE FROM films WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ('#{@title}', #{@price}) WHERE id = #{@id}; "
    SqlRunner.run(sql)
  end

  def tickets()
    sql = "SELECT * FROM tickets WHERE film_id = #{@id};"
    tickets = Ticket.get_many(sql)
    return tickets
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