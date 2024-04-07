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
  end

  def switch_player
    if @current_player == 'X'
      @current_player = 'O'
    else @current_player = 'X'
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
game.make_move(0, 0)
