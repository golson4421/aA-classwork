class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self.include?(key)
      self[key] << key
      @count += 1
    end
    resize! if @count > num_buckets
  end

  def remove(key)
    @count -= 1 if self.include?(key)
    self[key].delete(key)
  end

  def include?(key)
    @store.any? { |sub_arr| sub_arr.include?(key) }
  end

  private

  def [](key)
    num = key.hash % num_buckets
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @store += Array.new(num_buckets) { Array.new }
  end
end
