# frozen_string_literal: true

#-- Node Class for my linked list practice --#
class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

#-- class for linked list, need to add the other functions tomorrow at work --#
class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  def add_top(new_value)
    top_node = Node.new(new_value, @head)
    @head = top_node
  end
end

list = LinkedList.new

puts list.add_top('hello')
