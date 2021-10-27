require 'rspec'
require 'lru_cache'

describe LRUCache do
  subject(:johnny_cache) do
    LRUCache.new(4)
  end

  describe 'initialize' do
      it 'creates an instance of LRUCache' do
        expect(johnny_cache.class).to eq(LRUCache)
      end
  end

  describe 'count' do
      it 'returns the number of elements in the cache' do
          expect(johnny_cache.count).to eq(0)
      end
  end
