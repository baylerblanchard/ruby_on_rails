# frozen_string_literal: true

class KnightTravils
  BOARD_SIZE = 8

  MOVES = [
    [1, 2], [1, -2], [-1, 2], [-1, -2],
    [2, 1], [2, -1], [-2, 1], [-2, -1]
  ]

  def valid_moves(pos)
    x, y = pos
    valid_positions = []

    MOVES.each do |dx, dy|
      new_pos = [x + dx, y + dy]

      # Check if the new position is on the board
      if new_pos[0].between?(0, BOARD_SIZE - 1) && 
         new_pos[1].between?(0, BOARD_SIZE - 1)
        valid_positions << new_pos
      end
    end

    valid_positions
  end

  def print_board(path = [])
    # NEW: Print the text version of the route
    unless path.empty?
      puts "Route: #{path.map(&:to_s).join(" -> ")}"
    end

    puts "\n  " + (0...BOARD_SIZE).map { |i| " #{i} " }.join
    puts "  " + "-" * (BOARD_SIZE * 3)

    (0...BOARD_SIZE).to_a.reverse.each do |y|
      row_string = "#{y}|"
      (0...BOARD_SIZE).each do |x|
        current_pos = [x, y]

        if path.include?(current_pos)
          step_index = path.index(current_pos)
          if step_index == 0
            row_string += ' S '
          elsif step_index == path.length - 1
            row_string += ' E '
          else
            row_string += " #{step_index} "
          end
        else
          row_string += ' . '
        end
      end
      puts row_string
    end
    puts "  " + "-" * (BOARD_SIZE * 3)
  end


  # The Main Logic: Breadth-First Search to find the shortest path
  def find_path(start_pos, end_pos)
    # Queue holds paths (arrays of coordinates).
    # Start with a path containing just the starting position.
    queue = [[start_pos]]

    # Keep track of visited squares to avoid infinite loops
    visited = [start_pos]

    until queue.empty?
      # Dequeue the first path
      current_path = queue.shift
      current_pos = current_path.last

      # Check if we reached the destination
      return current_path if current_pos == end_pos

      # Explore neighbors
      valid_moves(current_pos).each do |move|
        unless visited.include?(move)
          visited << move
          # Create a new path extending the current one
          new_path = current_path + [move]
          queue << new_path
        end
      end
    end
  end
end

finder = KnightTravils.new
play = KnightTravils.new

play.print_board
play.find_path([0, 0], [1, 1])
path2 = finder.find_path([0, 0], [7, 0])
finder.print_board(path2)
