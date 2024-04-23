# this is my mastermind game coded in ruby

class Mastermind
  attr_accessor :key

  def initialize
    @key
  end

  def create_key
    @key = []
    color_list = ['red', 'blue', 'green', 'yellow', 'black', 'brown', 'white', 'grey', 'orange', 'pink', 'purple']
    @key = color_list.sample(4)
    puts 'this worked'
  end

  def play_game
    puts "play as guesser? Y/N"
    response = gets.chomp.downcase

    if guesser_response(response) == true
      play_as_guesser
    elsif guesser_response(response) == false
      puts 'this will play as the code maker'
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
    puts guess.split
  end

  def play_as_guesser
    total_guesses = 0
    while total_guesses <= 5
      puts 'please provide your guess: '
      response = gets.chomp.downcase
      guess_check(response)
      total_guesses += 1
    end
  end
end
game = Mastermind.new
game.create_key
puts game.key
game.play_game