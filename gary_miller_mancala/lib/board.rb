require 'byebug'

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1, @name2 = name1, name2
    @cups = Array.new(14, [])
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.map!.with_index { |cup, i| i == 6 || i == 13 ? cup : cup = [:stone, :stone, :stone, :stone] }
  end

  def valid_move?(start_pos)
    unless (0..5).include?(start_pos) || (7..12).include?(start_pos)
      raise "Invalid starting cup"
    end
    if @cups[start_pos].empty?
      raise "Starting cup is empty"
    end
    true
  end

  def make_move(start_pos, current_player_name)
    # empties selected cup
    stones_in_hand = []
    @cups[start_pos].each { |stone| stones_in_hand << stone }
    @cups[start_pos] = []
    ending_cup_idx = start_pos
    
    # distributes the stones from that cup
    until stones_in_hand.empty?
      stone = stones_in_hand.pop
      ending_cup_idx += 1
      if current_player_name == @name1
        if ending_cup_idx != 13
          @cups[ending_cup_idx] << stone
        elsif ending_cup_idx == 13 && stones_in_hand.first
          ending_cup_idx = 0
          @cups[ending_cup_idx] << stone
        end
      else
        if ending_cup_idx > 13
          ending_cup_idx = 0 
          @cups[ending_cup_idx] << stone
        elsif ending_cup_idx != 6 && ending_cup_idx != 13
          @cups[ending_cup_idx] << stone
        elsif ending_cup_idx == 6 && stones_in_hand.first
          ending_cup_idx += 1
          @cups[ending_cup_idx] << stone
        end
      end
    end
      self.render
      next_turn(ending_cup_idx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if @cups[ending_cup_idx].count > 1 && ending_cup_idx != 6 && ending_cup_idx != 13
        return ending_cup_idx
    elsif ending_cup_idx == 6 || ending_cup_idx == 13
        return :prompt
    elsif @cups[ending_cup_idx].count == 1 
        return :switch
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
