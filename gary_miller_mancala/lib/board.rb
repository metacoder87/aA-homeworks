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
    # distributes the stones from that cup
    debugger
    unless stones_in_hand.empty?
      if current_player_name == @name1
        (start_pos + 1..7).each { |cup| @cups[cup] << stones_in_hand.pop } if start_pos < 6 
        (start_pos + 1..12).each { |cup| @cups[cup] << stones_in_hand.pop } if start_pos > 6
      else
        (start_pos + 1..6).each { |cup| @cups[cup] << stones_in_hand.pop } if start_pos < 6
        (start_pos + 1..13).each { |cup| @cups[cup] << stones_in_hand.pop } if start_pos > 6
      end
      @cups.map! { |cup| cup.compact }
    end
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
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
