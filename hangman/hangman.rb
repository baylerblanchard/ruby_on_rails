word = 'hangman'
puts 'Enter your guess:'
guess = gets.chomp

words = []

file_path = 'google-10000-english-no-swears.txt'

File.open(file_path, 'r') do |file|
  # Code to read or modify the file goes here
  file.each_line do |line|
    words << line.chomp
  end
end

puts words
