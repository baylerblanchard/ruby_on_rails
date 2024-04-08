# class for tictactoe game
class TicTacToe
  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
    @current_player = 'X'
  end

  def display_board
    @board.each_with_index do |row, i|
      row_display = row.map { |cell| cell.nil? ? ' ' : cell }.join(' | ')
      puts row_display
      puts '-' * (row_display.length + 2) unless i == @board.length - 1
    end
    puts "\n\n"
  end

  def switch_player
    if @current_player == 'X'
      @current_player = 'O'
    else
      @current_player = 'X'
    end
  end

  def check_diag
    diagonals = [
      @board[0][0], @board[1][1], @board[2][2],
      @board[0][2], @board[1][1], @board[2][0]
    ]

    diagonals.each do |diag|
      return true if diag.uniq.length == 1 && diag[0] != ''
    end
    false
  end

  def check_win
    if check_diag = true
      puts "the diagonal wins"
    end
  end

  def make_move(row, col)
    @board[row][col] = @current_player
    display_board
    switch_player
  end
end

game = TicTacToe.new
game.display_board
game.make_move(1, 1)
game.make_move(0, 1)
game.make_move(0, 0)
game.make_move(0, 2)
game.make_move(2, 2)
game.check_win
