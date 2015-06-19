#mastermind.rb 
#A simple game of Mastermind made with object oriented principles in mind

module Mastermind
  class Pin
    attr_reader :color
    def initialize color
      @color = color
    end
  end


  class Row
    def initialize colors
      @row = colors.map do |color|
        Pin.new(color)
      end
    end

    def get_pins
      output_colors = @row.map do |pin|
        pin.color
      end
      output_colors
    end
  end


  class Board
    attr_reader :correct_row
    def initialize correct_row
      @correct_row = Row.new(correct_row)
      @guess_rows = []
    end

    def append_guess guess
      @guess_rows << Row.new(guess)
    end

    #checking how many pins in the row matches the correct pins and colors so that we can give feedback to the player
    def compare_rows guess = -1
      right_color = 0
      right_spot = 0 

      @guess_rows[guess].get_pins.each.with_index do |pin, index|
        if pin == @correct_row.get_pins[index]
          right_spot += 1
        end
      end
      right_color = ((@guess_rows[guess].get_pins) & (@correct_row.get_pins)).count
      [right_spot, right_color]
    end

    #this is for the bot so it can analyze past feedback from the board
    def compare_all_rows
      @guess_rows.map do |guess|
        right_color = 0 
        right_spot = 0
        guess.get_pins.each.with_index do |pin, index|
          if pin == @correct_row.get_pins[index]
            right_spot += 1
          end
        end
        right_color = (guess.get_pins & @correct_row.get_pins).count
        [right_spot, right_color - right_spot, guess]
      end
    end

    #these two dont do similar things
    #this is how many guesses have been guessed
    def guess_length
      @guess_rows.size
    end

    #and this is how many colors the correct answer has
    def code_length
      @correct_row.get_pins.size
    end
  end


  class Player
    attr_reader :name, :player_type

    #used to determine if a row is equal to the 
    def compare_input guess=-1, board
      #compare the last row to the first
      output = board.compare_rows(guess)
      puts "#{output[0]} correct pins, #{output[1]} pins off the right color"
      if output[0] == board.code_length
        correct_answer = true
      end
      correct_answer
    end
  end


  class HumanPlayer < Player
    def initialize
      @player_type = "human"
      print "Your name: "
      @name = gets.chomp
      print"\n"
    end

    def prompt_input board
      correct_answer = false

      puts "#{self.name} please guess the code"
      gets.chomp.split("")
    end 

    def new_game_code
      input = dialogue_and_prompt
      if not self.sanitize_input(input)
        input = dialogue_and_prompt
      end
      input
    end

    def dialogue_and_prompt
      puts "#{self.name}, please make a new code for the guesser to guess"
      gets.chomp.split("")
    end

    def sanitize_input input
      input.each do |x|
        if (1..6).include? x
          puts "Pshych that's some wrong numbahs"
          return false
        end
      end
      true
    end
  end


  class ComputerPlayer < Player
    def initialize
      @name = "AI1"
      @player_type = "computer"
    end

    def new_game_code
      output = Array.new(4) {"#{rand((1..6))}"}
      puts "#{self.name} has made a code for you to guess"
      output
    end

    def prompt_input board
      feedback = board.compare_all_rows
      real_ai = false
      puts feedback[2]

      if (not feedback.empty?) && real_ai
        random_probability = Array.new(4) {Array.new}
        feedback.each.with_index do |row, row_nr|
          row.each.with_index do |pin, pin_nr|
            puts ""
            puts "row_nr: #{row_nr}\nrow[2].getpins: #{row[2].get_pins} \n row[0]: #{row[0]}\n row[1]: #{row[1]}"
            inn = [] << row[2].get_pins * row[1]
            print inn
            inn[0] += Array.new(8) {row[2].get_pins[pin_nr] * row[0] }
            print inn
            random_probability[pin_nr] = inn
            #else
            #  random_probability[pin_nr] = row[2].get_pins * row[1] + row[2].get_pins[pin_nr] * row[0] * 8
            #end 
          end
        end
      #happens if the feedback is empty, makes 4 arrays with numbers 1-6
      else
        random_probability = Array.new(4) {(1..6).to_a.map {|n| "#{n}"}}
      end
      puts "random_probability: #{random_probability}"
      #puts "Array deciding shit: #{random_probability}"
      output = random_probability.map do |row|
        random_letter_from_given_list row
      end

      puts "the computer guessed: #{output} continue?"
      gets
      output
    end
  end

  def random_letter_from_given_list(row)
    row[rand row.length]
  end

  def play
    puts "Choos a mode: 1. two player mode 2. you make the code, computer guesses 3. computer 
          makes the code, you guess"
    mode = gets.chomp
    #only mode 1 and 3 are implemented right now, and 2 kinda
    #making the right player objects for the game
    if mode == "1"
      mastermind = HumanPlayer.new
      guesser = HumanPlayer.new
    elsif mode == "2"
      mastermind = HumanPlayer.new
      guesser = ComputerPlayer.new
    elsif mode == "3"
      mastermind = ComputerPlayer.new
      guesser = HumanPlayer.new
    end
    new_game = Board.new mastermind.new_game_code

    #this is where the "game" is run, 12 tries, the guesser loses if he cant guess it
    #assign a standard value to winner, if the if clause is not activated, mastermind wins,
    #else if the guesser manages to guess the correct combination the winner is set to guesser
    winner = mastermind
    until new_game.guess_length >= 12
      new_game.append_guess(guesser.prompt_input new_game)
      if guesser.compare_input(new_game) == true
        winner = guesser
        break
      end
      puts "#{12-new_game.guess_length} tries left"
    end
    puts "Congratulations to #{winner.name}"
  end
end


include Mastermind
play