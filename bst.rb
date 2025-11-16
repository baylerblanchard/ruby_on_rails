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

    new_node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if node.nil?

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root)
    return @root = Node.new(value) if @root.nil?
    return Node.new(value) if node.nil?

    value < node.data ? node.left = insert(value, node.left) : node.right = insert(value, node.right)
    node
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      # Node to be deleted is found

      # Case 1: Node with only one child or no child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # Case 2: Node with two children
      # Get the in-order successor (smallest in the right subtree)
      temp = next_min(node.right)
      # Copy the in-order successor's data to this node
      node.data = temp.data
      # Delete the in-order successor
      node.right = delete(temp.data, node.right)
    end
    node
  end

  def find(value, node = @root)
    return nil if node.nil?
    return node if node.data == value

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def level_order
    return [] if @root.nil?

    queue = [@root]
    result = []
    until queue.empty?
      current = queue.shift
      if block_given?
        yield current
      else
        result << current.data
      end
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
    end
    result unless block_given?
  end

  def inorder(node = @root, result = [], &block)
    return result if node.nil? && !block_given?
    return if node.nil?

    inorder(node.left, result, &block)
    block_given? ? yield(node) : result << node.data
    inorder(node.right, result, &block)
    result unless block_given?
  end

  def preorder(node = @root, result = [], &block)
    return result if node.nil? && !block_given?
    return if node.nil?

    block_given? ? yield(node) : result << node.data
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)
    result unless block_given?
  end

  def postorder(node = @root, result = [], &block)
    return result if node.nil? && !block_given?
    return if node.nil?

    postorder(node.left, result, &block)
    postorder(node.right, result, &block)
    block_given? ? yield(node) : result << node.data
    result unless block_given?
  end

  def height(node)
    return -1 if node.nil?

    1 + [height(node.left), height(node.right)].max
  end

  def balanced?
    check_balance(@root) != -1
  end

  private

  def next_min(node)
    current = node
    current = current.left until current.left.nil?
    current
  end

  def check_balance(node)
    return 0 if node.nil?

    left_height = check_balance(node.left)
    return -1 if left_height == -1

    right_height = check_balance(node.right)
    return -1 if right_height == -1

    return -1 if (left_height - right_height).abs > 1

    [left_height, right_height].max + 1
  end
end

new_array = [43, 23, 63, 1, 52, 85, 21, 87, 443, 643, 34, 555, 16]

mytree = Tree.new(new_array)

p mytree.root
mytree.pretty_print

mytree.insert(69)
mytree.insert(12)
mytree.insert(12_892)

mytree.pretty_print

mytree.delete(69)
mytree.delete(12)

mytree.delete(1234)

mytree.pretty_print

puts 'Finding 23:'
found_node = mytree.find(23)
if found_node
  puts 'Found node 23! Here is the subtree from that node:'
  mytree.pretty_print(found_node)
else
  puts 'Node 52 not found.'
end

puts 'Finding 1:'
p mytree.find(1)

puts "\nIn-order traversal:"
p mytree.inorder
puts "\nPre-order traversal:"
p mytree.preorder
puts "\nPost-order traversal:"
p mytree.postorder
puts "\nLevel-order traversal:"
p mytree.level_order

puts "\nIs the tree balanced?"
p mytree.balanced?

puts "\nAdding a few more nodes to unbalance the tree..."
mytree.insert(13_000)
mytree.insert(14_000)
puts "Is the tree balanced now?"
p mytree.balanced?
