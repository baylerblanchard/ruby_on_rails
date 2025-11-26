#lib/calculator.rb

class Calculator
  def add(*nums)
    sum = 0
    nums.each do |num|
      sum += num      
    end
    sum
  end
end
