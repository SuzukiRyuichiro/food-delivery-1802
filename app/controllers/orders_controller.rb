require_relative '../views/meals_view'
require_relative '../views/orders_view'
require_relative '../views/customers_view'
require_relative '../views/employees_view'

class OrdersController
  def initialize(order_repository, meal_repository, customer_repository, employee_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @orders_view = OrdersView.new
    @employees_view = EmployeesView.new
  end

  def add
    # display the meals
    meals = @meal_repository.all
    @meals_view.display(meals)
    # ask the user to choose a meal
    meal_index = @orders_view.ask_for_index
    meal = meals[meal_index]
    # display the customers
    customers = @customer_repository.all
    # ask the user to choose a customer
    @customers_view.display(customers)
    # ask the user to choose
    customer_index = @orders_view.ask_for_index
    customer = customers[customer_index]
    # display the riders
    riders = @employee_repository.all_riders
    @employees_view.display(riders)
    # ask the user to choose
    rider_index = @orders_view.ask_for_index
    rider = riders[rider_index]
    # create the order with the repository
    new_order = Order.new({ meal: meal, customer: customer, employee: rider })
    @order_repository.create(new_order)
  end

  def list_undelivered_orders
    # get all undelivered orders from the repo
    undeliverd_orders = @order_repository.undeliverd_orders
    # display them nicely
    @orders_view.display(undeliverd_orders)
  end
end
