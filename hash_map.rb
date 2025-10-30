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
    hash(value)

  end
end
