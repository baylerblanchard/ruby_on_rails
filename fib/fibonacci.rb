num = 37

def fibonacci(n)
  return n if n <= 0
  recursive_fib(n - 1)
end

def recursive_fib(n)
  return n if n <= 1
  recursive_fib(n - 1) + recursive_fib(n - 2)
end


def fib_seq(num)
  fib_array = []
  (1..num).each do |i|
    fib_array << fibonacci(i)
  end
  fib_array
end

p fibonacci(num)

p fib_seq(num)