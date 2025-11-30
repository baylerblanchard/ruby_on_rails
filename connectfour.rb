class Connect4
  # Using Unicode characters for the pieces makes it look nicer!
  PLAYER1_PIECE = "\u26AA" # White Circle
  PLAYER2_PIECE = "\u26AB" # Black Circle
  EMPTY_SLOT = ' '

  attr_reader :board, :current_player

  def initialize
    # A 6x7 board. 6 rows, 7 columns.
    @board = Array.new(6) { Array.new(7, EMPTY_SLOT) }
    @current_player = 1
  end

  # The main loop to run the game
  def play
    loop do
      display_board
      column = get_player_input
      row = drop_piece(column)

      if row
        if winner?(row, column)
          display_board
          puts "Player #{@current_player} wins!"
          break
        elsif draw?
          display_board
          puts "It's a draw!"
          break
        end
        switch_player
      else
        puts "Column is full. Please try another."
      end
    end
  end

  private

  def display_board
    puts "\n  1   2   3   4   5   6   7"
    puts "+---+---+---+---+---+---+---+"
    @board.each do |row|
      print '|'
      row.each { |cell| print " #{cell} |" }
      puts
      puts "+---+---+---+---+---+---+---+"
    end
    puts
  end

  def get_player_input
    loop do
      print "Player #{@current_player}, choose a column (1-7): "
      input = gets.chomp

      # Validate input is a number between 1 and 7
      if input.match?(/^[1-7]$/)
        column = input.to_i - 1 # Convert to 0-based index
        return column unless column_full?(column)
        puts "That column is full. Please choose another."
      else
        puts "Invalid input. Please enter a number between 1 and 7."
      end
    end
  end

  def drop_piece(column)
    # Find the lowest empty slot in the chosen column
    (5).downto(0) do |row|
      if @board[row][column] == EMPTY_SLOT
        @board[row][column] = current_piece
        return row # Return the row where the piece was placed
      end
    end
    nil # Return nil if the column is full
  end

  def column_full?(column)
    @board[0][column] != EMPTY_SLOT
  end

  def switch_player
    @current_player = @current_player == 1 ? 2 : 1
  end

  def current_piece
    @current_player == 1 ? PLAYER1_PIECE : PLAYER2_PIECE
  end

  def draw?
    # The game is a draw if the top row is full
    @board[0].none?(EMPTY_SLOT)
  end

  def winner?(row, col)
    piece = @board[row][col]
    # Check all four directions from the last placed piece
    check_direction(row, col, 1, 0, piece) ||  # Vertical
    check_direction(row, col, 0, 1, piece) ||  # Horizontal
    check_direction(row, col, 1, 1, piece) ||  # Diagonal (\)
    check_direction(row, col, 1, -1, piece)    # Diagonal (/)
  end

  def check_direction(row, col, d_row, d_col, piece)
    count = 0
    # Count in one direction
    (1..3).each do |i|
      r, c = row + i * d_row, col + i * d_col
      break unless in_bounds?(r, c) && @board[r][c] == piece
      count += 1
    end

    # Count in the opposite direction
    (1..3).each do |i|
      r, c = row - i * d_row, col - i * d_col
      break unless in_bounds?(r, c) && @board[r][c] == piece
      count += 1
    end

    # We need 4 in a row, so a count of 3 other pieces is a win
    count >= 3
  end

  def in_bounds?(row, col)
    row.between?(0, 5) && col.between?(0, 6)
  end
end

# This part allows you to run the file directly from the command line
if __FILE__ == $0
  game = Connect4.new
  game.play
end
