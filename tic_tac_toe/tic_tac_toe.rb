# this is the tic tac toe project

game_board = Array.new(3) { Array.new(3, ' ') }

game_board[0][0] = '#'
game_board[0][1] = '#'
game_board[0][2] = '#'
game_board[1][0] = '#'
game_board[1][1] = '#'
game_board[1][2] = '#'
game_board[2][0] = '#'
game_board[2][1] = '#'
game_board[2][2] = '#'

game_board.each { |row| puts row.join(" | ") }
puts "\n"
game_board[1][1] = 'X'

game_board.each { |row| puts row.join(" | ") }
puts "\n"

# tic tac toe class for the game
class TicTacToe
  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
    @current_player = 'X'
  end

  def display_board
    @board.each { |row| puts row.join(" | ") }
  end

  def make_move(row, col)
    if @board[row][col] = ' '
      @board[row, col] = @current_player
      switch_player
    else
      puts 'invalid move please try again'
    end
  end

  def switch_player
    @current_player = current_player == 'X' ? 'O' : 'X'
  end

  def check_row_col
    @board.each_with_index do |row, i|
      col = @board.map { |r| r[i] }
      return true if row.uniq.length == 1 && row[0] != ' '
      return true if col.uniq.length == 1 && col[0] != ' '
    end
  end

  def check_diag
    diagonals = [
      [@board[0][0], @board[1][1], @board[2][2]],
      [@board[0][2], @board[1][1], @board[2][0]]
    ]
    diagonals.each do |diag|
      return true if diag.uniq.length == 1 && diag[0] != ' '
    end
    false
  end

  def check_winner
    check_diag
    check_row_col
  end
end
