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
      [@board[0][0], @board[1][1], @board[2][2]],
      [@board[0][2], @board[1][1], @board[2][0]]
    ]

    diagonals.each do |diag|
      # Check if all elements are the same and not empty space
      if diag.uniq.length == 1 && diag[0] != ''
        return true
      end
    end
    false
  end

  def check_box_win
    # Check rows
    @board.each do |row|
      if row.uniq.length == 1 && row[0] != ''
        puts "Player #{switch_player} won!"
        return true
      end
    end
    # Check columns
    @board.transpose.each do |column|
      if column.uniq.length == 1 && column[0] != ''
        puts "Player #{switch_player} won!"
        return true
      end
    end
    false
  end

  def check_win
    check_box_win
    check_diag
  end

  def input_check(row, col)
    if row || col >= 3
      puts 'sorry move is not valid'
      return
    end
    if row || col <= 0
      puts 'sorry move is not valid'
      return
    end
  end

  def make_move(row, col)
    input_check(row, col)
    row = row.to_i
    col = col.to_i
    @board[row][col] = @current_player
    switch_player
  end

  def play
    winner = false
    while winner == false
      display_board
      puts 'Row selection: '
      row = gets.chomp
      puts 'Col selection: '
      col = gets.chomp
      make_move(row, col)
    end
  end
end

game = TicTacToe.new
game.play
