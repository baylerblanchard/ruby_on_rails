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
    @current_player = (current_player == 'X') ? 'O' : 'X'
  end
