# A parent class for all pieces
class Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  # We'll use Unicode characters for a nicer display
  def to_s
    ' ' # Placeholder
  end
end

# Example for a Rook
class Rook < Piece
  def to_s
    @color == :white ? '♖' : '♜'
  end
end

# You would create similar classes for King, Queen, Bishop, Knight, and Pawn.
class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    setup_pieces
  end

  def display
    puts "  a b c d e f g h"
    @grid.each_with_index do |row, i|
      print "#{8 - i} "
      puts row.map { |piece| piece.nil? ? '.' : piece.to_s }.join(' ')
    end
  end

  private

  def setup_pieces
    # This is a simplified setup. You would place all pieces.
    # Place Rooks
    @grid[0][0] = Rook.new(:black)
    @grid[0][7] = Rook.new(:black)
    @grid[7][0] = Rook.new(:white)
    @grid[7][7] = Rook.new(:white)

    # ... and so on for Knights, Bishops, Queens, Kings, and Pawns.
  end
end
class Game
  def initialize
    @board = Board.new
    @current_player = :white
  end

  def play
    loop do
      @board.display
      puts "It's #{@current_player}'s turn."
      puts "Enter your move (e.g., 'e2e4'):"
      
      move = gets.chomp
      # TODO: Parse the move string (e.g., 'e2e4') into coordinates.
      # TODO: Validate the move based on chess rules.
      # TODO: Update the board state.
      
      puts "Move received: #{move}" # Placeholder
      
      switch_player
    end
  end

  private

  def switch_player
    @current_player = (@current_player == :white) ? :black : :white
  end
end

# To start the game:
# game = Game.new
# game.play
