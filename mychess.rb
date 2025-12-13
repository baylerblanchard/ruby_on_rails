# A parent class for all pieces
class Piece
  attr_reader :color
  attr_accessor :has_moved

  def initialize(color)
    @color = color
    @has_moved = false
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

    # Castling Logic
    if !@has_moved
      row = current_pos[0]
      
      # Kingside Castle
      kingside_rook = board.grid[row][7]
      if kingside_rook.is_a?(Rook) && !kingside_rook.has_moved
        if board.grid[row][5].nil? && board.grid[row][6].nil?
          # Check if path is safe (Current, Cross, End)
          if !board.square_under_attack?([row, 4], @color) &&
             !board.square_under_attack?([row, 5], @color) &&
             !board.square_under_attack?([row, 6], @color)
            moves << [row, 6]
          end
        end
      end

      # Queenside Castle
      queenside_rook = board.grid[row][0]
      if queenside_rook.is_a?(Rook) && !queenside_rook.has_moved
        if board.grid[row][1].nil? && board.grid[row][2].nil? && board.grid[row][3].nil?
          if !board.square_under_attack?([row, 4], @color) &&
             !board.square_under_attack?([row, 3], @color) &&
             !board.square_under_attack?([row, 2], @color)
            moves << [row, 2]
          end
        end
      end
    end

    # 4. En Passant
    if board.last_double_step_pawn
      pawn_row, pawn_col = board.last_double_step_pawn
      if row == pawn_row && (col - pawn_col).abs == 1
        # The move target is behind the pawn being captured
        moves << [row + direction, pawn_col]
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
  attr_accessor :last_double_step_pawn

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    @captured_pieces = { white: [], black: [] }
    @last_double_step_pawn = nil
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

    # Handle Castling (King moves 2 squares)
    if moving_piece.is_a?(King) && (start_pos[1] - end_pos[1]).abs == 2
      row = start_pos[0]
      is_kingside = end_pos[1] > start_pos[1]
      
      old_rook_col = is_kingside ? 7 : 0
      new_rook_col = is_kingside ? 5 : 3
      
      rook = @grid[row][old_rook_col]
      @grid[row][new_rook_col] = rook
      @grid[row][old_rook_col] = nil
      rook.has_moved = true if rook
    end

    # TODO: Add move validation logic here.
    # A real move validation would check if the target square contains a friendly piece.

    captured_piece = @grid[end_pos[0]][end_pos[1]]
    
    # En Passant Capture Logic
    if moving_piece.is_a?(Pawn) && captured_piece.nil? && start_pos[1] != end_pos[1]
      captured_pawn_pos = [start_pos[0], end_pos[1]]
      captured_piece = @grid[captured_pawn_pos[0]][captured_pawn_pos[1]]
      @grid[captured_pawn_pos[0]][captured_pawn_pos[1]] = nil
    end

    if captured_piece
      # Add the captured piece to the appropriate list
      @captured_pieces[captured_piece.color] << captured_piece
    end

    @grid[end_pos[0]][end_pos[1]] = moving_piece
    @grid[start_pos[0]][start_pos[1]] = nil
    
    # Update last_double_step_pawn for En Passant tracking
    if moving_piece.is_a?(Pawn) && (start_pos[0] - end_pos[0]).abs == 2
      @last_double_step_pawn = end_pos
    else
      @last_double_step_pawn = nil
    end

    moving_piece.has_moved = true
    captured_piece # Return the captured piece, or nil
  end

  # Helper to check if a position is on the board
  def in_bounds?(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
  end

  def find_king(color)
    @grid.each_with_index do |row, r|
      row.each_with_index do |piece, c|
        return [r, c] if piece.is_a?(King) && piece.color == color
      end
    end
    nil
  end

  def in_check?(color)
    king_pos = find_king(color)
    opponent_color = (color == :white) ? :black : :white

    @grid.each_with_index do |row, r|
      row.each_with_index do |piece, c|
        next unless piece && piece.color == opponent_color
        # Check if any opponent piece can attack the king's position
        return true if piece.valid_moves([r, c], self).include?(king_pos)
      end
    end
    false
  end

  def square_under_attack?(pos, friendly_color)
    opponent_color = (friendly_color == :white) ? :black : :white
    @grid.each_with_index do |row, r|
      row.each_with_index do |piece, c|
        next unless piece && piece.color == opponent_color
        
        # Optimization: For Kings, check distance to avoid infinite recursion in valid_moves
        if piece.is_a?(King)
          return true if (r - pos[0]).abs <= 1 && (c - pos[1]).abs <= 1
        else
          return true if piece.valid_moves([r, c], self).include?(pos)
        end
      end
    end
    false
  end

  def has_legal_moves?(color)
    @grid.each_with_index do |row, r|
      row.each_with_index do |piece, c|
        next unless piece && piece.color == color
        piece.valid_moves([r, c], self).each do |move|
          return true unless move_leaves_king_in_check?([r, c], move, color)
        end
      end
    end
    false
  end

  def checkmate?(color)
    in_check?(color) && !has_legal_moves?(color)
  end

  def stalemate?(color)
    !in_check?(color) && !has_legal_moves?(color)
  end

  def move_leaves_king_in_check?(start_pos, end_pos, color)
    moving_piece = @grid[start_pos[0]][start_pos[1]]
    target_piece = @grid[end_pos[0]][end_pos[1]]
    
    # Handle En Passant simulation (capture is not at end_pos)
    en_passant_capture = nil
    if moving_piece.is_a?(Pawn) && target_piece.nil? && start_pos[1] != end_pos[1]
      captured_pawn_pos = [start_pos[0], end_pos[1]]
      en_passant_capture = @grid[captured_pawn_pos[0]][captured_pawn_pos[1]]
      @grid[captured_pawn_pos[0]][captured_pawn_pos[1]] = nil
    end

    @grid[end_pos[0]][end_pos[1]] = moving_piece
    @grid[start_pos[0]][start_pos[1]] = nil

    begin
      in_check?(color)
    ensure
      # Revert the move
      @grid[start_pos[0]][start_pos[1]] = moving_piece
      @grid[end_pos[0]][end_pos[1]] = target_piece
      # Revert En Passant capture
      if en_passant_capture
        captured_pawn_pos = [start_pos[0], end_pos[1]]
        @grid[captured_pawn_pos[0]][captured_pawn_pos[1]] = en_passant_capture
      end
    end
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

  def coords_to_algebraic(pos)
    row, col = pos
    rank = 8 - row
    file = (col + 'a'.ord).chr
    "#{file}#{rank}"
  end

  def get_ai_move
    moves = []
    @board.grid.each_with_index do |row, r|
      row.each_with_index do |piece, c|
        next unless piece && piece.color == @current_player
        piece.valid_moves([r, c], @board).each do |end_pos|
          unless @board.move_leaves_king_in_check?([r, c], end_pos, @current_player)
            target = @board.grid[end_pos[0]][end_pos[1]]
            # Score 1 for capture (including En Passant), 0 for move
            if target || (piece.is_a?(Pawn) && c != end_pos[1]) 
              score = 1
            else
              score = 0
            end
            moves << { start: [r, c], end: end_pos, score: score }
          end
        end
      end
    end
    best = moves.max_by { |m| m[:score] }
    candidates = moves.select { |m| m[:score] == (best ? best[:score] : 0) }
    choice = candidates.sample
    choice ? [choice[:start], choice[:end]] : nil
  end

  def play
    puts "Play against the computer? (y/n)"
    @vs_ai = gets.chomp.downcase.start_with?('y')

    loop do
      @board.display
      
      start_pos = nil
      end_pos = nil

      if @vs_ai && @current_player == :black
        puts "AI is thinking..."
        sleep(0.5)
        start_pos, end_pos = get_ai_move
        puts "AI plays #{coords_to_algebraic(start_pos)}#{coords_to_algebraic(end_pos)}"
      else
        puts "It's #{@current_player}'s turn."
        puts "Enter your move (e.g., 'e2e4') or 'resign':"
        move = gets.chomp
        if move.downcase == 'resign'
          puts "#{@current_player} resigns. Game over."
          break
        end

        if move.length != 4
          puts "Invalid format. Please use algebraic notation (e.g., 'e2e4')."
          next
        end
        start_alg, end_alg = move[0..1], move[2..3]
        start_pos = algebraic_to_coords(start_alg)
        end_pos = algebraic_to_coords(end_alg)
      end

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
            if @board.move_leaves_king_in_check?(start_pos, end_pos, @current_player)
              puts "Invalid move. You cannot leave or place your King in check."
              next
            end

            captured_piece = @board.move_piece(start_pos, end_pos)
            if captured_piece
              puts "#{captured_piece.class} (#{captured_piece.to_s}) was captured!"
            end

            if moving_piece.is_a?(Pawn)
              if (moving_piece.color == :white && end_pos[0] == 0) ||
                 (moving_piece.color == :black && end_pos[0] == 7)
                promote_pawn(end_pos)
              end
            end

            opponent = (@current_player == :white) ? :black : :white
            if @board.checkmate?(opponent)
              @board.display
              puts "Checkmate! #{@current_player} wins!"
              break
            elsif @board.stalemate?(opponent)
              @board.display
              puts "Stalemate! It's a draw."
              break
            elsif @board.in_check?(opponent)
              puts "Check!"
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

  def promote_pawn(pos)
    pawn = @board.grid[pos[0]][pos[1]]
    
    if @vs_ai && @current_player == :black
      choice = 'q'
    else
      puts "Pawn promotion! Choose (Q)ueen, (R)ook, (B)ishop, or (K)night:"
      loop do
        choice = gets.chomp.downcase
        break if ['q', 'r', 'b', 'k'].include?(choice)
        puts "Invalid choice. Please enter Q, R, B, or K."
      end
    end

    new_piece = case choice
                when 'q' then Queen.new(pawn.color)
                when 'r' then Rook.new(pawn.color)
                when 'b' then Bishop.new(pawn.color)
                when 'k' then Knight.new(pawn.color)
                end

    @board.grid[pos[0]][pos[1]] = new_piece
    puts "Pawn promoted to #{new_piece.class}!"
  end
end

# To start the game:
# game = Game.new
game = Game.new
game.play
