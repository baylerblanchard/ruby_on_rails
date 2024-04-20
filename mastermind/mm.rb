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

    if response == 'y'
      is_guesser = true
    elsif response == 'n'
      is_guesser = false
    else
      puts 'invalid input'
    end
  end
end
game = Mastermind.new
game.create_key
puts game.key
