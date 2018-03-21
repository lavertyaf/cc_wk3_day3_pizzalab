require('pg')
require('pry')
require_relative('pizza_order')
require_relative('../db/sql_runner')


class Customer
  attr_reader :id, :name

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
  end

  def self.all()
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run( sql )
    return customers.map { |person| Customer.new( person ) }
  end

  def save()
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
    results = SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
