require 'byebug'
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    prev_node = self.prev
    next_node = self.next
    prev_node.next = next_node
    next_node.prev = prev_node
  end
end

class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    self.head.next
  end

  def last
    self.tail.prev
  end

  def empty?
    first == self.tail
  end

  def get(key)
    search(key).val unless search(key).nil?
  end

  def include?(key)
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = self.tail.prev
    new_node.next = self.tail
    new_node.prev.next = new_node
    self.tail.prev = new_node
    new_node
  end

  def update(key, val)
    search(key).val = val unless search(key).nil?
  end

  def search(key)
    queue = [first]
    until queue.empty? || queue.first.key.nil?
      to_check = queue.shift
      if to_check.key == key
        return to_check
      else
        queue << to_check.next
      end
    end
    nil
  end

  def remove(key)
    search(key).remove unless search(key).nil?
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
