#this is the stock picker method

def stock_picker(day_prices)
    best_days = []
    max_profit = 0
    
    day_prices.each_with_index do |buy_price, buy_index|
        day_prices[buy_index+1..-1].each_with_index do |sell_price, sell_index|
            if sell_price -  buy_price > max_profit
                max_profit = sell_price - buy_price
                best_days = [buy_index, sell_index + buy_index +1]
            end
        end
    end
    best_days
end


puts stock_picker([12,1,45,6,77,3,124])