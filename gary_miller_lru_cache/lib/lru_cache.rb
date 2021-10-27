class LRUCache

    def initialize(n)
        @store = []
        @cache_limit = n
    end

    def count
      # returns number of elements currently in cache
        @store.count
    end

    def add(el)
      # adds element to cache according to LRU principle
        cancel_double?(el)
        limit_reached?
        @store << el
    end

    def show
      # shows the items in the cache, with the LRU item first
        print @store
    end

    private
    # helper methods go here!

    def cancel_double?(el)
        # Checks if the element is already in the Cache and removes it if it is.
        @store.delete(el) if @store.include?(el)
    end

    def limit_reached?
        # Checks if the cache is currently full and removes the oldest element if it is.
        @store.shift if count == @cache_limit
    end

end

# This is not your typical LRU Cache because the time complexity of this 
# algorithm with primitive Array data type does not scale well with larger
# cache sizes. My LRUCache#add method is also O(n) in order to search the 
# for an element before adding that element it must make a linear pass.
# If as the lesson described we had used a Doubley Linked List and accessed
# the links through a Hash key, we would be able to cut the add time down
# to O(1) Constant time amortized. 