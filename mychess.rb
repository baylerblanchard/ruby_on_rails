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

  # Default implementation for valid_moves. Subclasses should override this.
  def valid_moves(current_pos, board)
    [] # Return an empty array by default
  end
end

# Example for a Rook
class Rook < Piece
  def to_s
    @color == :white ? '♜' : '♖'
  end

  def valid_moves(current_pos, board)
    moves = []
    row, col = current_pos
    grid = board.grid

    # Directions: up, down, left, right
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]

    directions.each do |dr, dc|
      (1..7).each do |i|
        next_pos = [row + i * dr, col + i * dc]
        break unless board.in_bounds?(next_pos)

        target_piece = grid[next_pos[0]][next_pos[1]]
        if target_piece.nil?
          moves << next_pos # Empty square
        else
          moves << next_pos if target_piece.color != @color # Capture
          break # Blocked by a piece
        end
      end
    end
    moves
  end
end

class King < Piece
  def to_s
    @color == :white ? '♚' : '♔'
  end

  def valid_moves(current_pos, board)
    moves = []
    row, col = current_pos
    grid = board.grid

    # King can move one square in any direction
    directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],           [0, 1],
      [1, -1],  [1, 0],  [1, 1]
    ]

    directions.each do |dr, dc|
      next_pos = [row + dr, col + dc]
      if board.in_bounds?(next_pos)
        target_piece = grid[next_pos[0]][next_pos[1]]
        if target_piece.nil? || target_piece.color != @color
          moves << next_pos
        end
      end
    end
    moves
  end
end

class Queen < Piece
  def to_s
    @color == :white ? '♛' : '♕'
  end

  def valid_moves(current_pos, board)
    moves = []
    row, col = current_pos
    grid = board.grid

    # Queen combines Rook and Bishop movement (all 8 directions)
    directions = [
      [-1, 0], [1, 0], [0, -1], [0, 1],   # Orthogonal
      [-1, -1], [-1, 1], [1, -1], [1, 1]  # Diagonal
    ]

    directions.each do |dr, dc|
      (1..7).each do |i|
        next_pos = [row + i * dr, col + i * dc]
        break unless board.in_bounds?(next_pos)

        target_piece = grid[next_pos[0]][next_pos[1]]
        if target_piece.nil?
          moves << next_pos # Empty square
        else
          moves << next_pos if target_piece.color != @color # Capture
          break # Blocked by a piece
        end
      end
    end
    moves
  end
end

class Bishop < Piece
  def to_s
    @color == :white ? '♝' : '♗'
  end

  def valid_moves(current_pos, board)
    moves = []
    row, col = current_pos
    grid = board.grid

    # Directions: all four diagonals
    directions = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

    directions.each do |dr, dc|
      (1..7).each do |i|
        next_pos = [row + i * dr, col + i * dc]
        break unless board.in_bounds?(next_pos)

        target_piece = grid[next_pos[0]][next_pos[1]]
        if target_piece.nil?
          moves << next_pos # Empty square
        else
          moves << next_pos if target_piece.color != @color # Capture
          break # Blocked by a piece
        end
      end
    end
    moves
  end
end

class Knight < Piece
  def to_s
    @color == :white ? '♞' : '♘'
  end

  def valid_moves(current_pos, board)
    moves = []
    row, col = current_pos
    grid = board.grid

    # All 8 possible L-shaped moves
    potential_moves = [
      [row - 2, col - 1], [row - 2, col + 1],
      [row - 1, col - 2], [row - 1, col + 2],
      [row + 1, col - 2], [row + 1, col + 2],
      [row + 2, col - 1], [row + 2, col + 1]
    ]

    potential_moves.each do |move|
      if board.in_bounds?(move)
        target_piece = grid[move[0]][move[1]]
        moves << move if target_piece.nil? || target_piece.color != @color
      end
    end
    moves
  end
end

class Pawn < Piece
  def to_s
    @color == :white ? '♟' : '♙'
  end

  # Returns an array of possible end positions
  def valid_moves(current_pos, board)
    moves = []
    row, col = current_pos
    grid = board.grid

    # Direction depends on color
    direction = (@color == :white) ? -1 : 1

    # 1. Standard one-step forward
    one_step = [row + direction, col]
    moves << one_step if board.in_bounds?(one_step) && grid[one_step[0]][one_step[1]].nil?

    # 2. Initial two-step forward
    is_starting_pos = (@color == :white && row == 6) || (@color == :black && row == 1)
    if is_starting_pos && moves.include?(one_step) # Can only move 2 if 1 is clear
      two_steps = [row + (2 * direction), col]
      moves << two_steps if board.in_bounds?(two_steps) && grid[two_steps[0]][two_steps[1]].nil?
    end

    # 3. Diagonal captures
    [col - 1, col + 1].each do |capture_col|
      capture_pos = [row + direction, capture_col]
      if board.in_bounds?(capture_pos)
        target_piece = grid[capture_pos[0]][capture_pos[1]]
        # Can capture if there's a piece of the opposite color
        moves << capture_pos if target_piece && target_piece.color != @color
      end
    end

    moves
  end
end

# You would create similar classes for King, Queen, Bishop, Knight, and Pawn.
class Board
  attr_reader :grid, :captured_pieces

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    @captured_pieces = { white: [], black: [] }
    setup_pieces
  end

  def display
    puts "  a b c d e f g h"
    @grid.each_with_index do |row, row_index|
      print "#{8 - row_index} "
      puts row.map { |piece| piece.nil? ? '·' : piece.to_s }.join(' ')
    end
    puts "  a b c d e f g h"
  end

  def move_piece(start_pos, end_pos)
    moving_piece = @grid[start_pos[0]][start_pos[1]]
    return nil if moving_piece.nil? # No piece to move

    # TODO: Add move validation logic here.
    # A real move validation would check if the target square contains a friendly piece.

    captured_piece = @grid[end_pos[0]][end_pos[1]]
    if captured_piece
      # Add the captured piece to the appropriate list
      @captured_pieces[captured_piece.color] << captured_piece
    end

    @grid[end_pos[0]][end_pos[1]] = moving_piece
    @grid[start_pos[0]][start_pos[1]] = nil
    captured_piece # Return the captured piece, or nil
  end

  # Helper to check if a position is on the board
  def in_bounds?(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
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
      if move.length != 4
        puts "Invalid format. Please use algebraic notation (e.g., 'e2e4')."
        next
      end

      start_alg, end_alg = move[0..1], move[2..3]

      start_pos = algebraic_to_coords(start_alg)
      end_pos = algebraic_to_coords(end_alg)

      if start_pos && end_pos
        moving_piece = @board.grid[start_pos[0]][start_pos[1]]

        if moving_piece.nil?
          puts "Invalid move. There is no piece at #{start_alg}."
        elsif moving_piece.color != @current_player # This is the crucial check
          puts "Invalid move. You can only move your own pieces (#{@current_player})."
        else
          # If the piece belongs to the current player, THEN check for valid moves.
          possible_moves = moving_piece.valid_moves(start_pos, @board)

          if possible_moves.include?(end_pos)
            captured_piece = @board.move_piece(start_pos, end_pos)
            if captured_piece
              puts "#{captured_piece.class} (#{captured_piece.to_s}) was captured!"
            end
            switch_player
          else
            puts "Invalid move for a #{moving_piece.class}."
          end
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
