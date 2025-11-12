# frozen_string_literal: true

# Node class for the nodes of the tree
class Node
  attr_accessor :left, :righ, :data

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
    @root = build_tree(processed_array, 0, processed_array.length-1)
  end

  def build_tree(array, start_index, end_index)
    mid_index = array.length / 2
    @root = Node.new(array[mid_index])


  end
end

mytree = Tree.new([43, 23, 63, 1, 52, 85, 21, 87, 443, 643, 34, 555])

p mytree.root
p mytree
