require("pry")
require_relative('../models/pizza_order')
require_relative('../models/customer')

PizzaOrder.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'Zsolt' })
customer1.save()

order_details = {
  'customer_id' => customer1.id,
  'topping' => 'Pepporini',
  'quantity' => 1
}

order1 = PizzaOrder.new(order_details)
order1.save
#
# found_order = PizzaOrder.find(1)

p PizzaOrder.all()

# binding.pry
nil
