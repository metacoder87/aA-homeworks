# Big O is for Octopus Algorithms

class Octopus

attr_reader :school, :tiles_array, :new_tiles_data_structure

    def initialize  # Creates the Octopus class with a school of fish, array of tiles and a hash of those tiles
        @school = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
        @tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
        @new_tiles_data_structure = {}
        new_data_filler
    end
    # A Very Hungry Octopus wants to eat the longest fish in an array of fish.

    # Sluggish Octopus

        # Find the longest fish in O(n^2) time. Do this by comparing all fish 
        # lengths to all other fish lengths

    def sluggish_octopus # O(n^2)
        @school.each do |craniata| 
            return craniata if @school.all? { |cran| cran.length <= craniata.length }
        end
    end

    # Dominant Octopus
        # Find the longest fish in O(n log n) time. Hint: You saw a sorting 
        # algorithm that runs in O(n log n) in the Sorting Complexity Demo. 
        # Remember that Big O is classified by the dominant term.

    def dominant_octopus # O(n*log(n))
        merge_sort(@school).last
    end

    # Clever Octopus

        # Find the longest fish in O(n) time. 
        # The octopus can hold on to the longest fish that you have 
        # found so far while stepping through the array only once.


    def clever_octopus # O(n)
        biggest_fish = ""
        @school.each { |craniata| craniata.length > biggest_fish.length ? biggest_fish = craniata : next }
        return biggest_fish
    end

    # DANCING OCTOPUS

        # Full of fish, the Octopus attempts Dance Dance Revolution. 
        # The game has tiles in the following directions: tiles_array = 
        # [
            # "up", "right-up", "right", "right-down", 
            # "down", "left-down", "left",  "left-up" 
        # ]

        # To play the game, the octopus must step on a tile with her 
        # corresponding tentacle. We can assume that the octopus's eight 
        # tentacles are numbered and correspond to the tile direction indices.

    # Slow Dance

        # Given a tile direction, iterate through a tiles array to return 
        # the tentacle number (tile index) the octopus must move. 
        # This should take O(n) time.

    def slow_dance(move, tiles) # O(n)
        tiles.each_with_index do |tile, idx| 
            return idx if tile == move
        end
    end

    # Constant Dance!

        # Now that the octopus is warmed up, let's help her dance faster. 
        # Use a different data structure and write a new function 
        # so that you can access the tentacle number in O(1) time.

    def fast_dance(move, tiles) # O(1)
        return tiles[move]
    end 

    private

    def new_data_filler
        @tiles_array.each_with_index { |tile, idx| @new_tiles_data_structure[tile] = idx }
    end

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
puts oct.slow_dance("up", oct.tiles_array) # => 0
puts oct.slow_dance("right-down", oct.tiles_array) # => 3
puts oct.fast_dance("up", oct.new_tiles_data_structure) # => 0
puts oct.fast_dance("right-down", oct.new_tiles_data_structure) # => 3