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

