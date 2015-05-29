#mastermind.rb 
#A simple game of Mastermind made with object oriented principles in mind

module Mastermind
  class Pin
    attr_reader :color
    def initialize(color)
      @color = color
    end
  end

  class Row
    def initialize(colors)
      @row = colors.map do |color|
        Pin.new(color)
      end
    end

    def get_pins
      output_colors  = @row.map do |pin|
        pin.color
      end
      output_colors
    end
  end

  class Board
    def initialize(correct_row)
      @correct_row = Row.new(correct_row)
      @guess_rows = []
    end

    def append_guess(guess)
      @guess_rows << Row.new(guess)
    end
  end

  class Player
  end

  def play
    new_row = Row.new(["blue", "red", "yellow", "orange"])
    print new_row.get_pins
  end
end

include Mastermind

play