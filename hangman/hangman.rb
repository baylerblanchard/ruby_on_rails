attempts = 6
words = []


file_path = 'google-10000-english-no-swears.txt'

File.open(file_path, 'r') do |file|
  # Code to read or modify the file goes here
  file.each_line do |line|
    words << line.chomp
  end
end

word = words.sample

word.each do |letter|
  word_blank =

end

puts word

while attempts != 0
  puts 'Enter your guess:'
  guess = gets.chomp

  if guess == word
    puts 'congrats you won'
  elsif guess != word
    attempts -= 1
  end
end
