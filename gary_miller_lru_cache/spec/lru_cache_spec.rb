require 'rspec'
require 'lru_cache'

describe LRUCache do
  subject(:johnny_cache) do
    LRUCache.new(4)
  end
