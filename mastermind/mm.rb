# this is my mastermind game coded in ruby

class Mastermind
  attr_accessor :key, :total_guesses

  def create_key
    @key = []
    color_list = ['red', 'blue', 'green', 'yellow', 'black', 'brown', 'white', 'grey', 'orange', 'pink', 'purple']
    @key = color_list.sample(4)
    puts 'this worked'
  end

  def play_game
    puts 'play as guesser? Y/N'
    response = gets.chomp.downcase

    if guesser_response(response) == true
      play_as_guesser
    elsif guesser_response(response) == false
      ai_is_guesser
    end
  end

  def guesser_response(char)
    if char == 'y'
      true
    elsif char == 'n'
      false
    else
      puts 'invalid input'
    end
  end

  def guess_check(guess)
    return 'guess is empty' if guess.nil? || guess.empty?

    if guess == key
      player_won
    elsif guess.split == key
      player_won
    end
  end

  def ai_is_guesser
    @total_guesses = 0
    while @total_guesses <= 5
      guess = @key.sample(4)
      puts "AI's guess: #{guess.join(', ')}"
      guess_check(guess)
      @total_guesses += 1
    end
  end

  def play_as_guesser
    @total_guesses = 0
    while @total_guesses <= 5
      puts 'please provide your guess: '
      response = gets.chomp.downcase
      guess_check(response)
      @total_guesses += 1
    end
  end

  def player_won
    puts 'key is correct! you win!'
    @total_guesses = 5
  end
end

game = Mastermind.new
game.create_key
puts game.key
game.play_game
