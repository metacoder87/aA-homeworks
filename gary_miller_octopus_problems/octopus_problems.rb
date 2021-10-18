# Big O is for Octopus Algorithms

class Octopus

    attr_reader :school

    def initialize
        @school = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
    end

    def sluggish_octopus # O(n^2)
        @school.each do |craniata| 
            return craniata if @school.all? { |cran| cran.length <= craniata.length }
        end
    end

    def dominant_octopus # O(n*log(n))
        merge_sort(@school).last
    end

    def clever_octopus # O(n)
        biggest_fish = ""
        @school.each { |craniata| craniata.length > biggest_fish.length ? biggest_fish = craniata : next }
        return biggest_fish
    end

    # DANCING OCTOPUS

    def slow_dance(move, tiles) # O(n)
        tiles.each_with_index do |tile, idx| 
            return idx if tile == move
        end
    end

    private

      # Merge Sort: O(n*lg(n))
    def merge_sort (array, &prc)
        return array if array.length <= 1

        mid_idx = array.length / 2
        merge(
        merge_sort(array.take(mid_idx), &prc),
        merge_sort(array.drop(mid_idx), &prc),
        &prc
        )
    end

    # NB: In Ruby, shift is an O(1) operation. This is not true of all languages.
    def merge(left, right, &prc)
        merged_array = []
        prc = Proc.new { |fish1, fish2| fish1.length <=> fish2.length } unless block_given?
        until left.empty? || right.empty?
        case prc.call(left.first, right.first)
        when -1
            merged_array << left.shift
        when 0
            merged_array << left.shift
        when 1
            merged_array << right.shift
        end
        end

        merged_array + left + right
    end

end

oct = Octopus.new
puts oct.sluggish_octopus
puts oct.dominant_octopus
puts oct.clever_octopus