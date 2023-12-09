class GrocerCart
    AVAILABLE_PRODUCTS = ["milk", "bread", "banana", "apple"]
    PRICING_TABLE = {
        'milk' => { unit_price: 3.97, sale_price_quantity: 2, sale_price: 5.00 },
        'bread' => { unit_price: 2.17, sale_price_quantity: 3, sale_price: 6.00 },
        'banana' => { unit_price: 0.99, sale_price_quantity: 0.00, sale_price: 0.00 },
        'apple' => { unit_price: 0.89, sale_price_quantity: 0.00, sale_price: 0.00 }
      }

    attr_accessor :user_name

    def initialize(user_name)
        @user_name = user_name
        @cart = Hash.new()
        @sold_products = Hash.new()
    end

    def process_order
        puts "*******************************************************"
        puts "User: #{@user_name}"
        print "Please enter all the items purchased 'seprated by comma':"
        cashier_input = gets.chomp.downcase.split(",").map(&:strip)
        AVAILABLE_PRODUCTS.each { |product| @cart[product] = cashier_input.count(product) }
        calculate_purchased_product
        print_invoice
    end

    def calculate_purchased_product
        @cart.each do |item, quantity|
            listed_product_details = PRICING_TABLE[item]
            if listed_product_details[:sale_price_quantity] == quantity
                @sold_products[item] = {quantity: quantity, amount: listed_product_details[:sale_price]}
            elsif quantity > listed_product_details[:sale_price_quantity] && listed_product_details[:sale_price_quantity] != 0
                no_of_discount_units = quantity / listed_product_details[:sale_price_quantity]
                discounted_products = no_of_discount_units * listed_product_details[:sale_price_quantity]
                undiscounted_products = quantity - discounted_products
                discounted_price = no_of_discount_units * listed_product_details[:sale_price]
                undiscounted_price = undiscounted_products * listed_product_details[:unit_price]
                total_amount = (discounted_price + undiscounted_price)&.round(2)
                @sold_products[item] = {quantity: quantity, amount: total_amount}
            else
                total_amount = quantity * listed_product_details[:unit_price]&.round(2)
                @sold_products[item] = {quantity: quantity, amount: total_amount}
            end
        end
    end

    def print_invoice
        puts "\nItem     Quantity      Price"
        puts '--------------------------------------'
        @sold_products.each do |product, details|
            puts "#{product}         #{details[:quantity]}           #{details[:amount]}"
        end
        total_purached_amount = @sold_products.values.sum { |item| item[:amount] }
        puts "\nTotal price : $#{total_purached_amount&.round(2)}"
        total_savings = puts "You saved $#{()&.round(2)}"
        puts "You saved $#{(total_savings)&.round(2)}" if total_savings != 0
    end

    def calculate_total_amount
        @cart.sum{ |product, quantity| PRICING_TABLE[product][:unit_price] * quantity }
    end
end
