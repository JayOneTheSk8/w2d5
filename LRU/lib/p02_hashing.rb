class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    acc = 0
    self.each_with_index do |el, idx|
      acc += (el.hash + idx.hash) ^ acc
    end
    acc
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.sort_by { |k, v| v }.hash
  end
end
