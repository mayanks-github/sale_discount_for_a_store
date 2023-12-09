require_relative 'grocery_cart'

continue_shoping = true

user_data = Hash.new()

while continue_shoping
    print "Enter the name of user: "
    user_name = gets.chomp.downcase
    user_data[user_name.gsub(/\s+/, '_').to_sym] = GrocerCart.new(user_name).process_order

    print "Do we want to continue inserting customer details ? Y/N : "
    cashier_input = gets.chomp.downcase.strip
    continue_shoping = false if ["n", "no"].include?(cashier_input)
    
end