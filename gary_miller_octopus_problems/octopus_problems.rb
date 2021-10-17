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
    end

end