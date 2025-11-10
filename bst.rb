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
  attr_accessor :root, :data

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(data)
  end

  def build_tree(array)
    mid = array.length / 2
    @root = array[mid]
  end
end

mytree = Tree.new([43, 23, 63, 1, 52, 85, 21, 87, 443, 643, 34])

puts mytree
