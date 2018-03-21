require('pg')
require('pry')
require_relative('../db/sql_runner')



class Customer
  attr_reader :id, :name

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
  end

  # def self.all()
  #   sql = "SELECT * FROM customers;"
  #   customers = SqlRunner.run( sql )
  #   return customers.map { |person| Customer.new( person ) }
  # end

  def save()
    #get the result
    db = PG.connect( { dbname: 'pizza_shop', host: 'localhost' } )
    sql = "INSERT INTO customers
    (
     name
    )
    VALUES
    (
     $1
    )
    RETURNING id"
    values = [@name]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    db.close()


    #do things with result
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    db = PG.connect( { dbname: 'pizza_shop', host: 'localhost' } )
    sql = "DELETE FROM customers"
    db.prepare("delete_all", sql)
    result = db.exec_prepared("delete_all")
    db.close()
  end

end
