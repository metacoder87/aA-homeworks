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
    end

    def show
      # shows the items in the cache, with the LRU item first
    end

    private
    # helper methods go here!

end