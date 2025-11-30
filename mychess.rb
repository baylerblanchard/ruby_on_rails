class Chess
  attr_accessor :row, :column, :player1, :player2

  def initialize
    @row = 8
    @column = 8
    @player1 = 'new'
    @player2 = 'player'

  end

  def player_choice
    first_turn = [player1, player2].sample
    first_turn
  end
end


new_chess = Chess.new

puts new_chess.row
puts new_chess.column
puts new_chess.player_choice
