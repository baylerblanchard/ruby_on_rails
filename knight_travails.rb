# frozen_string_literal: true

# For tracking visited nodes, a Set is more efficient (O(1) lookup) than an Array (O(n) lookup).
require 'set'

# Corrected typo in the class name
class KnightTravails
  BOARD_SIZE = 8

  MOVES = [
    [1, 2],  [1, -2], [-1, 2], [-1, -2],
    [2, 1], [2, -1], [-2, 1], [-2, -1]
  ]

  def valid_moves(pos)
    x, y = pos
    valid_positions = []
    # Refactored to be more idiomatic using map and select.
    MOVES.map { |dx, dy| [x + dx, y + dy] }
         .select do |new_x, new_y|
           new_x.between?(0, BOARD_SIZE - 1) &&
             new_y.between?(0, BOARD_SIZE - 1)
         end
  end

  def print_board(path = [])
    # NEW: Print the text version of the route
    unless path.empty?
      puts "Route: #{path.map(&:to_s).join(" -> ")}"
      puts "It took #{path.length - 1} moves to get to the end."
    end

    puts "\n  " + (0...BOARD_SIZE).map { |i| " #{i} " }.join
    puts '  ' + '-' * (BOARD_SIZE * 3)

    (0...BOARD_SIZE).to_a.reverse.each do |y|
      row_string = "#{y}|"
      (0...BOARD_SIZE).each do |x|
        current_pos = [x, y]

        if path.include?(current_pos)
          step_index = path.find_index(current_pos)
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
    puts '  ' + '-' * (BOARD_SIZE * 3)
  end

  # The Main Logic: Breadth-First Search to find the shortest path
  # Refactored to be more memory-efficient by storing predecessors instead of full paths in the queue.
  def find_path(start_pos, end_pos)
    # The queue now holds only the positions to visit.
    queue = [start_pos]

    # Keep track of visited squares to avoid infinite loops
    # Using a Set for O(1) lookups is more efficient.
    visited = Set[start_pos]

    # This hash will store the predecessor of each square, allowing us to reconstruct the path later.
    predecessors = {}

    until queue.empty?
      current_pos = queue.shift

      # Check if we reached the destination
      return reconstruct_path(predecessors, start_pos, end_pos) if current_pos == end_pos

      # Explore neighbors
      valid_moves(current_pos).each do |move|
        unless visited.member?(move)
          visited << move
          predecessors[move] = current_pos
          queue << move
        end
      end
    end
    nil # Return nil if no path is found
  end

  private

  # Helper method to reconstruct the path from the predecessors hash.
  def reconstruct_path(predecessors, start_pos, end_pos)
    path = []
    current = end_pos
    while current
      path.unshift(current)
      current = predecessors[current]
    end
    path
  end
end

# This block only runs when the script is executed directly.
if __FILE__ == $0
  finder = KnightTravails.new
  start_node = [0, 0]
  end_node = [7, 7]
  path = finder.find_path(start_node, end_node)
  finder.print_board(path)
end
