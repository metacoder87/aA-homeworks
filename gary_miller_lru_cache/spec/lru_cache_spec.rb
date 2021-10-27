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

  describe 'add' do
      it 'adds an element to the array' do
        johnny_cache.add("I walk the line")
        johnny_cache.add(5)
          expect(johnny_cache.count).to eq(2)
      end
  end

  describe 'cancel_double?' do
      it 'removes element before adding a new one' do
        johnny_cache.add("I walk the line")
        johnny_cache.add(5)
        johnny_cache.add([1,2,3])
        johnny_cache.add(5)
          expect(johnny_cache.count).to eq(3)
      end
  end

  describe 'limit_reached?' do
      it 'will not add more than four elements without deleting the first' do
        johnny_cache.add(-5)
        johnny_cache.add({a: 1, b: 2, c: 3})
        johnny_cache.add([1,2,3,4])
        johnny_cache.add("I walk the line")
        johnny_cache.add(:ring_of_fire)
        johnny_cache.add("I walk the line")
        johnny_cache.add({a: 1, b: 2, c: 3})
            expect(johnny_cache.count).to eq(4)
      end
  end

  describe 'show' do
      it 'prints the contents of the cache' do
        johnny_cache.add(-5)
        johnny_cache.add({a: 1, b: 2, c: 3})
        johnny_cache.add([1,2,3,4])
        johnny_cache.add("I walk the line")
        johnny_cache.add(:ring_of_fire)
        johnny_cache.add("I walk the line")
          expect { johnny_cache.show }.to output(
              "[{:a=>1, :b=>2, :c=>3}, [1, 2, 3, 4], :ring_of_fire, \"I walk the line\"]"
            ).to_stdout
      end
  end

end