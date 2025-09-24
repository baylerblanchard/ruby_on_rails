num = 8

def fibonacci(n)
  return nil if n <= 0
  recursive_fib(n - 1)
end

def recursive_fib(n)
  return n if n <= 1
  recursive_fib(n - 1) + recursive_fib(n - 2)
end

puts fibonacci(num)

def fib_seq(num)
  fib_array = []
  (1..num).each do |i|
    fib_array << fibonacci(i)
  end
  fib_array
end

p fib_seq(num)