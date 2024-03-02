puts "this is my first ruby program"

name = 'bayler blanchard'

first_name = name.split(' ')[0]
last_name = name.split(' ')[1]

puts "First name: #{first_name}"
puts "Last name: #{last_name}"
puts "Full name: #{first_name} #{last_name}"
puts "is he hard?"

hard = 0

until hard >= 69
    hard += 1
    puts hard 
end

puts "#{first_name} #{last_name} is finally hard"

# array exercises
a = []

a << 1
a << first_name

a << last_name

puts a

# hash exercises
employee = {
  first: "bayler",
  last: "blanchard",
  h: "6 ft",
  w: "140 lbs"
}

puts employee

puts employee.keys
puts employee.values


puts "\nnew section\n\n"
#methods work

def display_name(first, last)
    puts "First name: #{first}"
    puts "Last name: #{last}"
end

display_name(first_name, last_name)

display_name('ben', 'blanchard')

def are_they_hard(hard)
    until hard >= 69
        hard += 1
        puts hard 
    end
    puts "they are finally hard"
end

are_they_hard(23)

make_hard = 0

def will_they_be_hard(make_hard)
    until make_hard >= 69
        make_hard += 1
        puts make_hard 
    end
    puts "they are finally hard"
end


# debugging exampless

require 'pry-byebug'

# First, we're going to practice reading the Stack Trace
# Don't look at this method prior to running the test
# Type 'rspec' into the terminal to run Rspec
# Once this test fails, have a look at the Stack Trace
# Try to see if you can work your way from the last line, the bottom of the stack
# To the top, the first line, where the error occured, and ONLY THEN fix the error

def decrement_smallest_value(nested_array)
  smallest_value = nested_array.flatten.max
  nested_array.each do |array|
    array.each do |current_value|
      if smallest_value > current_value
        smallest_value = current_value
      end
    end
  end
  smallest_value -= 1
end

# use the stack trace to debug the following method
# Don't look at this method prior to running the test
# Run rspec, let the test fail, and go through the stack trace again
def increment_greatest_value(nested_array)
  greatest_value = nested_array.flatten.min
  nested_array.each do |array|
    array.each do |current_value|
      if greatest_value < current_value
        greatest_value = current_value
      end
    end
  end
  greatest_value += 1
end

# This next exercise might look familiar
# Use p and puts in order to find what's wrong with our method

def isogram?(string)
  original_length = string.length
  string_array = string.downcase.split('')
  unique_length = string_array.uniq.length
  original_length == unique_length
end

# Can you guess what's next?
# That's right! The final exercise from the lesson, which we'll debug with pry-byebug
# Try to avoid looking at the problem too much, let's rely on pry to fix it
# First, include require 'pry-byebug' at the top of this page
# Next insert plenty of breakpoints, and see if you can tell where things break
# Once you find the error, fix it and get the test to pass

def yell_greeting(string)
  name = string
  name = name.upcase
  greeting = "WASSAP, #{name}!"
end

#end of the debuuging exercises

#enum practice

dynasty_members = ['bayler', 'ben', 'austin', 'justyn', 'brodie', 'jon', 'kadeem']
dynasty_admin = []

dynasty_members.each {|member| dynasty_admin.push(member.upcase)}
puts dynasty_admin

#finished the nested array examples