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

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

end