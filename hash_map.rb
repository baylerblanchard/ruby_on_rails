# frozen_string_literal: true

class HashMap
  attr_reader :capacity, :load_factor, :size

  DEFAULT_CAPACITY = 16
  DEFAULT_LOAD_FACTOR = 0.75

  def initialize(initial_capacity = DEFAULT_CAPACITY, load_factor = DEFAULT_LOAD_FACTOR)
    @capacity = initial_capacity
    @load_factor = load_factor
    # Initialize buckets as an array of empty arrays
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    resize if (@size.to_f / @capacity) >= @load_factor

    index = get_index(key)
    bucket = @buckets[index]

    # Look for the key in the bucket
    existing_pair = bucket.find { |pair| pair[0] == key }

    if existing_pair
      # Key found, update the value
      existing_pair[1] = value
    else
      # Key not found, append the new [key, value] pair
      bucket << [key, value]
      @size += 1
    end
  end

  def get(key)
    index = get_index(key)
    bucket = @buckets[index]

    pair = bucket.find { |p| p[0] == key }

    # Return the value (pair[1]) if pair is found, otherwise return nil
    pair ? pair[1] : nil
  end

  def has?(key)
    # We can just check if get(key) returns something other than nil
    !get(key).nil?
  end

  def remove(key)
    index = get_index(key)
    bucket = @buckets[index]

    pair = bucket.find { |p| p[0] == key }

    if pair
      # Use delete_if for efficient removal from the bucket array
      bucket.delete_if { |p| p[0] == key }
      @size -= 1
      return pair[1] # Return the value
    end

    # Key not found
    nil
  end

  def length
    @size
  end

  def clear
    @capacity = DEFAULT_CAPACITY
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  def keys
    # Iterate all buckets, flatten into one array of pairs, then map to keys
    @buckets.flatten(1).map { |pair| pair[0] }
  end

  def values
    @buckets.flatten(1).map { |pair| pair[1] }
  end

  def entries
    @buckets.flatten(1)
  end

  def print_buckets
    puts "--- Buckets (Size: #{@size}, Capacity: #{@capacity}) ---"
    @buckets.each_with_index do |bucket, index|
      puts "  [#{index}]: #{bucket.inspect}" unless bucket.empty?
    end
    puts '--------------------------------------------------------'
  end

  private
  

  def get_index(key)
    hash_code = hash(key)
    # Use modulo to ensure the index is within the @capacity
    hash_code % @capacity
  end
end
