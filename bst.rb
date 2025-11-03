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

class Tree
  attr_accessor :root, :data

  def initialize(array)
    
  end
end