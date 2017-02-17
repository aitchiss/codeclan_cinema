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

end