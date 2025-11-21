# frozen_string_literal: true

class KnightTravils
  BOARD_SIZE = 8

  def print_board(path = [])
    puts "\n  " + (0...BOARD_SIZE).map { |i| " #{i} " }.join
    puts "  " + "-" * (BOARD_SIZE * 3)

    # Iterate through rows (usually y-axis in 2D grids)
    # We reverse 0..7 so that index 0,0 is at the bottom-left (Cartesian style)
    # or keep it normal for Matrix style (0,0 top-left).
    # Standard chess boards have rank 8 at the top, so let's reverse the rows.
    (0...BOARD_SIZE).to_a.reverse.each do |y|
      row_string = "#{y}|"
      (0...BOARD_SIZE).each do |x|
        current_pos = [x, y]

        if path.include?(current_pos)
          # If this square is in the path, print its step number
          step_index = path.index(current_pos)
          if step_index == 0
            row_string += " S " # Start
          elsif step_index == path.length - 1
            row_string += " E " # End
          else
            row_string += " #{step_index} "
          end
        else
          # Empty square
          row_string += " . " 
        end
      end
      puts row_string
    end
    puts "  " + "-" * (BOARD_SIZE * 3)
  end
end
play = KnightTravils.new

play.print_board
