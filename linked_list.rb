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

  def add_bottom(new_value)
    new_node = Node.new(new_value)

    if @head.nil?
      @head = new_node
      return
    end

    current_node = @head
    while current_node.next_node
      current_node = current_node.next_node
    end

    current_node.next_node = new_node
  end

  def pop
    return nil if @head.nil?

    if @head.next_node.nil?
      value_to_return = @head.value
      @head = nil
      return value_to_return
    end

    current_node = @head
    while !current_node.next_node.next_node.nil?
      current_node = current_node.next_node
    end

    value_to_return = current_node.next_node.value

    current_node.next_node = nil

    return value_to_return
  end

  def size
    count = 0
    current_node = @head

    while !current_node.nil?
      count += 1
      current_node = current_node.next_node
    end

    puts "the size of this linked list is: #{count}"
  end

  def get(index)
    current_node = @head
    current_index = 0

    while !current_node.nil? && current_index < index
      current_node = current_node.next_node
      current_index += 1
    end
    puts current_node.value
  end

  def return_head
    @head.value
  end

  def contains?(value)
    current_node = @head
    while !current_node.nil?
      if current_node.value == value
        return true
      end
      current_node = current_node.next_node
    end
    return false
  end

  def tail
    current_node = @head

    return nil if @head.nil?

    until current_node.next_node.nil?
      current_node = current_node.next_node
    end

    return current_node.value
  end

  def print_list
    return puts 'list is empty' if @head.nil?

    current_node = @head
    while current_node
      print "#{current_node.value} -> "
      current_node = current_node.next_node
    end
    puts 'nil'
  end
end

try_hard = 'ben'
list = LinkedList.new

list.add_top('hello')
list.add_top('world')
list.add_top(25)
list.add_top(2.65)
list.add_top(try_hard)
list.add_bottom('bayler')
list.add_top(42)
list.add_bottom('blue jays')
list.add_bottom('yankees')
list.get(4)

list.print_list

puts list.return_head

puts list.tail
puts list.contains?('bluejays')

list.size
puts list.pop
list.print_list
