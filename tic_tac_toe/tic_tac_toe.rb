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

  def check_win
    # Check rows
    @board.each do |row|
      return true if row.uniq.length == 1 && row[0] != ' '
    end

    # Check columns
    @board.transpose.each do |col|
      return true if col.uniq.length == 1 && col[0] != ' '
    end

    # Check diagonals
    if (@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && @board[0][0] != ' ') ||
       (@board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && @board[0][2] != ' ')
      return true
    end

    false
  end

  def input_check(row, col)
    if row.to_i.negative? || row.to_i > 2 || col.to_i.negative? || col.to_i > 2
      puts 'Invalid input. Please enter a number between 0 and 2.'
      false
    else
      true
    end
  end

  def make_move(row, col)
    input_check(row, col)
    row = row.to_i
    col = col.to_i
    @board[row][col] = @current_player
  end

  def user_selection
    display_board
    valid_input = false
    row = nil
    col = nil
    until valid_input
      puts 'Row selection: '
      row = gets.chomp
      puts 'Col selection: '
      col = gets.chomp
      if input_check(row, col)
        valid_input = true
      else
        puts 'Invalid input. Please enter a number between 0 and 2.'
      end
    end
    make_move(row, col)
  end

  def board_full?
    @board.all? do |row|
      row.none? { |cell| cell == ' ' }
    end
  end

  def play_game
    loop do
      user_selection
      if check_win
        display_board
        puts "Player #{@current_player} has won!"
        break
      elsif board_full?
        puts "It's a draw!"
        break
      end
      switch_player
    end
  end
end

game = TicTacToe.new
game.play_game
