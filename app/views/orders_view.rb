class OrdersView
  def ask_for_index
    puts "Please choose a number"
    gets.chomp.to_i - 1
  end
end
