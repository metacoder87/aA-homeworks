require 'colorize'

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over
      take_turn
    end 
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence 
    require_sequence
    unless @game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    num = 1
    @seq.each do |color|
      system 'clear'
       if color == "red"
        puts "#{num}. #{color.red}"
       elsif color == "blue"
        puts "#{num}. #{color.cyan}"
       elsif color == "yellow"
        puts "#{num}. #{color.light_yellow}"
       else
        puts "#{num}. #{color.green}"
       end
      sleep(1.5)
      system 'clear'
      num += 1
    end
  end

  def require_sequence
    sequence = []
    until sequence.length == @seq.length || sequence != @seq.first(sequence.length)
      if sequence.empty? 
        puts "Input the colors you remember, in order, one at a time."
      else puts "Next color..."
      end
      sequence << gets.chomp.to_s
      system 'clear'
      @game_over = true if sequence != @seq.first(sequence.length)
    end
  end

  def add_random_color
    @seq << ["red", "blue", "yellow", "green"].shuffle.first
  end

  def round_success_message
    puts "Keep it up, you're doing GREAT!"
  end

  def game_over_message
    puts "Simon Says, game over. Good job though you made it to round #{@sequence_length}."
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

simon = Simon.new
simon.play
