#lib/calculator.rb

class Calculator
  def add(*nums)
    sum = 0
    nums.each do |num|
      sum += num      
    end
    sum
  end

  def multiply(*nums)
    product = 0
    nums.each do |num|
      product *= num
    end
  end
end
