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
  end
end
