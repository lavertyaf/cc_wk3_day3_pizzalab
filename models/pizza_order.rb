require('pg')
require('pry')

class PizzaOrder

  attr_accessor :customer_id, :topping, :quantity
  attr_reader :id

  def initialize(options)
    @customer_id = options['customer_id'].to_i
    @topping = options['topping']
    @quantity = options['quantity'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "INSERT INTO pizza_orders
    (
      customer_id,
      topping,
      quantity
    ) VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@customer_id, @topping, @quantity]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def update()
    sql = "
    UPDATE pizza_orders SET (
      first_name,
      last_name,
      topping,
      quantity
    ) =
    (
      $1, $2, $3, $4
    )
    WHERE id = $5"
    values = [@first_name, @last_name, @topping, @quantity, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM pizza_orders where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    values = [id]
    sql = "SELECT * FROM pizza_orders WHERE id = $1"
    results = SqlRunner.run(sql, values)
    p results
    order_hash = results.first
    order = PizzaOrder.new(order_hash)
    return order
  end

  def self.delete_all()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "DELETE FROM pizza_orders"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def self.all()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
    sql = "SELECT * FROM pizza_orders"
    db.prepare("all", sql)
    orders = db.exec_prepared("all")
    db.close()
    return orders.map { |order| PizzaOrder.new(order) }
  end

end
