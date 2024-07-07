# this is a class for my hangman game
class HangmanGame
  def initialize
    @attempts = 6
    @words = []
    @file_path = 'google-10000-english-no-swears.txt'
    File.open(@file_path, 'r') do |file|
      file.each_line do |line|
        @words << line.chomp
      end
    end
    @word = @words.sample
    @word_blank = '_ ' * @word.length
  end

  def save_game
<<<<<<< HEAD
    File.open('hangman_save.txt', 'w') do |file|
      file.puts(self.instance_variables.map { |var| "#{var}=#{self.instance_variable_get(var).inspect}" unless var == :@words })
    end
  end

  # Open the saved game file
  def self.open_save
    game = self.new
    File.open('hangman_save.txt', 'r') do |file|
      # Read the saved game state
      saved_game_state = file.read
      # Process the saved game state as saved_game_state = file.read.split("\n")
      saved_game_state.each do |var|
        var_name, var_value = var.split('=')
        game.instance_variable_set(var_name, eval(var_value))
      end
    end
    game
  end
=======
  File.open('hangman_save.txt', 'w') do |file|
    file.puts(game.instance_variables.map { |var| "#{var}=#{game.instance_variable_get(var).inspect}" unless var == :@words })
  end
end

# Open the saved game file
def open_save
  File.open('hangman_save.txt', 'r') do |file|
    # Read the saved game state
    saved_game_state = file.read
    # Process the saved game state as needed
    # ...
  end
end
>>>>>>> b508acdd43399b546e826945cd6bf484f1235eea

  def play_game
    while @attempts.positive?
      puts "Attempts left: #{@attempts}"
      puts "Word: #{@word_blank}"
      puts 'Guess a letter: '
      guess = gets.chomp.downcase

      if guess.length != 1 || !guess.match?(/[a-z]/)
        puts 'Invalid input. Please enter a single letter.'
        next
      end

      if @word.include?(guess)
        @word.chars.each_with_index do |letter, index|
          @word_blank[index * 2] = letter if letter == guess
        end

        if @word_blank.include?('_')
          puts 'Correct guess! Keep going.'
          puts 'Would you like to save Y/N?'
          save_bool = gets.chomp.downcase
          if save_bool == 'y'
            save_game
          end
        else
          puts "Congratulations! You guessed the word: #{@word}"
          return
        end
      else
        @attempts -= 1
        puts "Wrong guess! Attempts left: #{@attempts}"
        puts 'Would you like to save Y/N?'
        save_bool = gets.chomp.downcase
        if save_bool == 'y'
          save_game
        end
      end
    end

    puts "Game over! The word was: #{@word}"
  end
end

puts "is this a new game?Y/N"
ans = gets.chomp.downcase

if ans =

game = HangmanGame.new
puts game.instance_variable_get(:@word)

game.play_game
