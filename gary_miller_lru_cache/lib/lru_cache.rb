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
        @store.delete(el) if @store.include?(el)
    end
end