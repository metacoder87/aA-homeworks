class MaxIntSet

  attr_reader :store

  def initialize(max)
    @store = Array.new(max) { false }
    @nums = []
    @max = max
  end

  def insert(num)
    if is_valid? num
      @nums << num
      @store[num] = true
    end
  end

  def remove(num)
    @nums.delete(num)
    @store[num] = false
  end

  def include?(num)
    @nums.one? { |n| n == num }
  end

  private

  def is_valid?(num)
    if num.class == Integer && num <= @max && num >= 0
      return true
    else raise "Out of bounds"
    end
  end

  def validate!(num)
    num.to_i if num.class != Integer
    num = @max if num > @max
    num = 0 if num < 0 
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket(num) << num
  end

  def remove(num)
    bucket(num).delete(num)
  end

  def include?(num)
    @store.any? { |n| n.include? num }
  end

  private

  def bucket(num)
    # optional but useful; return the bucket corresponding to `num`
    @store[19 % num]
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
  end

  def remove(num)
  end

  def include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
  end
end
