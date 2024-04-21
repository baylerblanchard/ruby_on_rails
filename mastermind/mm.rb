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
      puts 'this will play the guesser'
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

  def play_as_guesser

  end

  def play_other

  end
end
game = Mastermind.new
game.create_key
puts game.key
game.play_game
