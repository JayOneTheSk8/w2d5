require 'byebug'

class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num < @max && num > 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless self[num].include?(num)
  end

  def remove(num)
    self[num].delete(num) if self[num].include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    i = num % num_buckets
    @store[i]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless full?
      unless self[num].include?(num)
        self[num] << num
        @count += 1
      end
    else
      # debugger
      resize!
      insert(num)
      # self[num] << num
      # @count += 1
    end
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  def full?
    count >= num_buckets
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % num_buckets
    @store[i]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.dup
    old_store.flatten!
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }
    until old_store.empty?
      insert(old_store.shift)
    end
  end
end
