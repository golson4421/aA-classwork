class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hash_val = self.first.hash
    self.each_with_index do |el,i|
      next if i == 0
      hash_val ^= (i*el+el).hash
    end
    hash_val
  end
end

class String
  def hash
    alpha = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a.map(&:to_s)
    self.split('').map { |char| alpha.index(char) }.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    mapped = self.map { |k, v| [k, v] }
    mapped.sort_by!(&:first)
    mapped.flatten.join.hash
  end
end
