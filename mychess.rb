class Chess
  attr_accessor :player1, :player2
  attr_reader :board

  def initialize
    # An 8x8 board, initialized with empty spaces ' '
    @board = Array.new(8) { Array.new(8, ' ') }
    @player1 = 'Player 1'
    @player2 = 'Player 2'

  end

  def player_choice
    [@player1, @player2].sample
  end

  def print_board
    puts
    puts "   a  b  c  d  e  f  g  h"
    puts "  +--+--+--+--+--+--+--+--+"
    @board.each_with_index do |row, index|
      # Print row numbers from 8 down to 1
      print "#{8 - index} |"
      # Join the squares in the row with a separator
      print row.join(' |')
      puts " |"
      puts "  +--+--+--+--+--+--+--+--+"
    end
    puts
  end
end

new_chess = Chess.new

puts new_chess.player_choice
new_chess.print_board
