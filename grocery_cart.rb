class GrocerCart
    AVAILABLE_PRODUCTS = ["milk", "bread", "banana", "apple"]
    PRICING_TABLE = {
        'milk' => { unit_price: 3.97, sale_price_quantity: 2, sale_price: 5.00 },
        'bread' => { unit_price: 2.17, sale_price_quantity: 3, sale_price: 6.00 },
        'banana' => { unit_price: 0.99, sale_price_quantity: 0.00, sale_price: 0.00 },
        'apple' => { unit_price: 0.89, sale_price_quantity: 0.00, sale_price: 0.00 }
      }

    def initialize()
        @cart = Hash.new()
    end

    def process_order
        puts "Please enter all the items purchased seprated by comma:"
        cashier_input = gets.chomp.downcase.split(",").map(&:strip)
        AVAILABLE_PRODUCTS.each { |product| @cart[product] = cashier_input.count(product) }
    end
end

first_cart = GrocerCart.new.process_order