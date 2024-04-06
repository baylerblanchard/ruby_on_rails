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
