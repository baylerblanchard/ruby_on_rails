# this is a class for my hangman game
require 'json'

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

  # Save the game state to a file
  def save_game
    File.open('hangman_save.txt', 'w') do |file|
      game_state = self.instance_variables.each_with_object({}) do |var, hash|
        hash[var] = self.instance_variable_get(var) unless var == :@words
      end
      file.puts(JSON.dump(game_state))
    end
  end

  # Open the saved game file
  def self.open_save
    game = self.new
    File.open('hangman_save.txt', 'r') do |file|
      # Read the saved game state
      saved_game_state = JSON.load(file)
      saved_game_state.each do |var, value|
        game.instance_variable_set(var, value)
      end
    end
    game
  end

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

if ans == 'y'
  game = HangmanGame.itself.open_save

else
  game = HangmanGame.new
end

puts game.instance_variable_get(:@word)

game.play_game
