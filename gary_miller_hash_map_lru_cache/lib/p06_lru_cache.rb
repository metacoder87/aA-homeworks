require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :max, :prc

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    @map[key] ? update_node!(@map[key]) : calc!(key)
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  attr_reader :store, :map

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = self.prc.call(key)
    new_node = store.append(key, val)
    map[key] = new_node

    eject! if count > self.max
    val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
  end
end
