#this is the stock picker method

def stock_picker(day_prices)
    profit = 0
    best_days = []

    
    length = day_prices.length
    puts length
    
    for day in day_prices
        puts day_prices[day]
      
    end
    

    puts "best days #{best_days}"
end


stock_picker([12,1,45,6,77,3,24])