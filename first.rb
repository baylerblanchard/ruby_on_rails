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
