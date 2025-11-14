# frozen_string_literal: true

# Node class for the nodes of the tree
class Node
  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

# Tree class for bst
class Tree
  attr_accessor :root

  def initialize(array)
    processed_array = array.sort.uniq
    @root = build_tree(processed_array, 0, processed_array.length - 1)
  end

  def build_tree(array, start_index, end_index)
    if start_index > end_index
      return nil
    end

    mid_index = (start_index + end_index) / 2
    new_node = Node.new(array[mid_index])

    new_node.left = build_tree(array, start_index, mid_index - 1)
    new_node.right = build_tree(array, mid_index + 1, end_index)

    return new_node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

mytree = Tree.new([43, 23, 63, 1, 52, 85, 21, 87, 443, 643, 34, 555])

mytree.pretty_print
