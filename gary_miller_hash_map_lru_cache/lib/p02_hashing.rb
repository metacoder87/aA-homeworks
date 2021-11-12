class Integer
  # Integer#hash already implemented for you
end

class Array

  def hash
    alph = ("a".."z").to_a
    shing = self.map.with_index do |el, i|
      if el.class == Integer
        el ^ i
      elsif el.class == String
        alph.index(el)
      end
    end
    ha = shing.join('').to_i.hash
  end

end

class String

  def hash
    self.split('').hash
  end

end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
