require 'byebug'

class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    @store.store[i]
  end

  def []=(i, val)
    @store.store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    @store.store.any? { |el| el == val } 
  end

  def push(val)
    resize! if @count == capacity
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    new_val = val
    @store.store.each.with_index do |ele, idx|
      @store[idx] = new_val
      new_val = ele
    end
    @count += 1
  end

  def pop
    return nil if first.nil?
    popped = last
    @store[@count - 1] = nil
    @count -= 1
    return popped
  end

  def shift
    return first if first.nil?
    shifted = first

    @store.store.each.with_index do |el, idx|
      @store[idx - 1] = el if idx > 0
    end
    @count -= 1
    return shifted
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each
    @store.store.each { |ele| yield ele }
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
    return other == @store.store
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity)
    @count = 0
    self.each do |ele|
      new_store.store << ele
    end
    @store = new_store
  end
end
