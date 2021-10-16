# Big O is for Octopus Algorithms

class Octopus

    attr_reader :fish

    def initialize
        @school = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
    end

    def sluggish_octopus
        @school.each { |craniata| return craniata if @school.all? { |cran| cran.length <= craniata.length } }
    end

end