#this is the stock picker method

def stock_picker(day_prices)
    profit = 0
    best_days = []

    day_prices.each_with_index.select do |day, index|
      puts "day: #{index}, price: #{day}"
      
    end
   
    

    puts "best days #{best_days}"
end


stock_picker([12,1,45,6,77,3,24])