puts "this is my first ruby program"

name = 'bayler blanchard'

first_name = name.split(' ')[0]
last_name = name.split(' ')[1]

puts "First name: #{first_name}"
puts "Last name: #{last_name}"
puts "Full name: #{first_name} #{last_name}"
puts "is he hard?"

hard = 0

unless hard < 69
  puts "yes"
  puts "#{first_name} is hard"
  puts "he is hard"
else
  puts "no"
  puts "#{first_name} is not hard"
  hard +=1
end

# array exercises
a = []

a << 1
a << first_name

a << last_name
