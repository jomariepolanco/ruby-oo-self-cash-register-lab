require 'pry'
class CashRegister

    attr_accessor :total, :last_transaction_amount, :discount 

    def initialize(apply_discount = 0)
        @total = 0 
        @discount = apply_discount
        @cart = [] #to start CashRegister, there is a new cart to be rung through
    end
    
    def add_item(title, price, quantity = 0)
        items = {} #all the items information goes into a hash for easier storage
        items[:title] = title
        items[:price] = price 
        items[:quantity] = quantity 
        if quantity == 0
            @total += price
        else
            @total += price * quantity 
        end
        @last_transaction_amount = @total 
        @cart << items #push hashes of each added item to cart array. this is what they are paying for (receipt)
    end


    def apply_discount
        if @discount > 0 
            @total = @total - @total * (@discount.to_f / 100)
            return "After the discount, the total comes to $#{@total.to_i}."
        elsif @discount == 0
            return "There is no discount to apply."
        end 
    end

    def items
        item_array = []
        @cart.map do |items| # use .map return an array
            if items[:quantity] > 0
                item_array.fill(items[:title], item_array.size, items[:quantity])
                # .fill to use quantity of tomato to create array. .fill adds in item[:title] starting at the end of the array (.size) item[:quantity] times
            elsif items[:quantity] == 0
                item_array << items[:title]
            end 
        end
        item_array = item_array.flatten #flatten the .fill array so it's only 1 array total
    end 

    def void_last_transaction
            @last_transaction_amount -= @cart[@cart.length - 1][:price] #the new total is the total - the price of the last item in the cart array
            @cart.delete(@cart[@cart.length - 1]) #cart updated to remove the last item
            @total = @last_transaction_amount 
        if @cart.length == 0
            @total = 0
        end 
    end
end
