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
  end

  def play_game
    game = Mastermind.new
    game.create_key
    i = 0
    guess_attempt = 0

    for i in 12
      puts "guess number: #{i}"
      i += i
    end

  end
end
game = Mastermind.new
game.play_game
puts game.key
