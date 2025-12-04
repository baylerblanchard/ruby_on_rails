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

class King < Piece
  def to_s
    @color == :white ? '♔' : '♚'
  end
end

class Queen < Piece
  def to_s
    @color == :white ? '♕' : '♛'
  end
end

class Bishop < Piece
  def to_s
    @color == :white ? '♗' : '♝'
  end
end

class Knight < Piece
  def to_s
    @color == :white ? '♘' : '♞'
  end
end

class Pawn < Piece
  def to_s
    @color == :white ? '♙' : '♟'
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
      puts row.map { |piece| piece.nil? ? '·' : piece.to_s }.join(' ')
    end
    puts "  a b c d e f g h"
  end

  def move_piece(start_pos, end_pos)
    piece = @grid[start_pos[0]][start_pos[1]]
    return false if piece.nil? # No piece to move

    # TODO: Add move validation logic here.

    @grid[end_pos[0]][end_pos[1]] = piece
    @grid[start_pos[0]][start_pos[1]] = nil
    true
  end

  private

  def setup_pieces
    # Black pieces
    @grid[0][0] = Rook.new(:black)
    @grid[0][1] = Knight.new(:black)
    @grid[0][2] = Bishop.new(:black)
    @grid[0][3] = Queen.new(:black)
    @grid[0][4] = King.new(:black)
    @grid[0][5] = Bishop.new(:black)
    @grid[0][6] = Knight.new(:black)
    @grid[0][7] = Rook.new(:black)
    (0..7).each { |i| @grid[1][i] = Pawn.new(:black) }

    # White pieces
    (0..7).each { |i| @grid[6][i] = Pawn.new(:white) }
    @grid[7][0] = Rook.new(:white)
    @grid[7][1] = Knight.new(:white)
    @grid[7][2] = Bishop.new(:white)
    @grid[7][3] = Queen.new(:white)
    @grid[7][4] = King.new(:white)
    @grid[7][5] = Bishop.new(:white)
    @grid[7][6] = Knight.new(:white)
    @grid[7][7] = Rook.new(:white)
  end
end
class Game
  def initialize
    @board = Board.new
    @current_player = :white
  end

  # Translates algebraic notation (e.g., "e2") to array coordinates (e.g., [6, 4])
  def algebraic_to_coords(alg_notation)
    return nil unless alg_notation.match?(/^[a-h][1-8]$/)

    file = alg_notation[0]
    rank = alg_notation[1]

    row = 8 - rank.to_i
    col = file.ord - 'a'.ord
    [row, col]
  end

  def play
    loop do
      @board.display
      puts "It's #{@current_player}'s turn."
      puts "Enter your move (e.g., 'e2e4'):"
      
      move = gets.chomp
      start_alg, end_alg = move[0..1], move[2..3]

      start_pos = algebraic_to_coords(start_alg)
      end_pos = algebraic_to_coords(end_alg)

      if start_pos && end_pos
        # TODO: Validate the move based on chess rules and current player.
        if @board.move_piece(start_pos, end_pos)
          switch_player
        else
          puts "Invalid move. There is no piece at #{start_alg}."
        end
      else
        puts "Invalid format. Please use algebraic notation (e.g., 'e2e4')."
      end
    end
  end

  private
  
  def switch_player
    @current_player = (@current_player == :white) ? :black : :white
  end
end

# To start the game:
# game = Game.new
game = Game.new
game.play
