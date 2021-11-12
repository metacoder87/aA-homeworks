class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    
    unless include?(key)
      bucket(key) << key 
      @count += 1
    end
  end

  def include?(key)
    bucket(key).one? { |n| n == key }
  end

  def remove(key)
    @count -= 1 if include?(key)
    bucket(key).delete(key)
  end

  private

  def bucket(num)
    return @store[0] if num == 0
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % (num_buckets - 1)]
  end

  def num_buckets
    @store.length
  end

  def resize!
  end
end
