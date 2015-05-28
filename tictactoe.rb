#   ||   ||
# 1 || 2 || 3
#   ||   ||
#===||===||===
#   ||   ||
# 4 || 5 || 6
#   ||   ||   
#===||===||===
#   ||   ||   
# 7 || 8 || 9
#   ||   ||

#

module TicTacToe
  class Cell
    attr_accessor :status, :owner
    def initialize(status="_")
      @status = status
    end
  end

  class Player
    attr_reader :name, :symbol
    def initialize
      print "Your name: "
      @name = gets.chomp
      print"\n"
      print "Choose a symbol: "
      @symbol = gets.chomp
      print "\n"
    end
  end

  class Board
    def initialize
      @board = 9.times.map do 
        Cell.new
      end
    end

    def print_board
      @board.each.with_index do |tile, index|
        index += 1

        if index % 3 == 0
          puts tile.status
        else
          print "#{tile.status}|"
        end
      end

      puts
    end

    def change_board(tile, player)
      @board[tile - 1].status = player.symbol
      @board[tile - 1].owner = player
    end

    def win_condition
      win_conditions = [(0..2).to_a, (3..5).to_a, (6..8).to_a, [0,4,8], [2,4,6], [0,3,6], [1,4,7], [2,5,8]]
      win_conditions_values = win_conditions.map do |condition|
        condition.map do |cell_number|
          @board[cell_number].owner
        end
      end
      win_conditions_values.each do |condition|
        if condition.uniq.count == 1 && condition[0]
          return condition[0]
        end
      end
      false
    end
  end

  def play
    board = Board.new
    player1 = Player.new
    player2 = Player.new

    current_player = player1
    next_player = player2
    until board.win_condition
      board.print_board
      puts "#{current_player.name}'s turn"
      puts "What tile?: "
      input = gets.to_i
      board.change_board(input, current_player)

      current_player, next_player = next_player, current_player

    end


    board.print_board
    puts "Congratulations #{board.win_condition.name} you won"
  end


  #debug function full off bullshit
  #
  def debug
    newcell = Cell.new
    if newcell.owner
      puts "newcell.owner is true when no value is set"
    else
      puts "newcell.owner is false when no value is set"
    end
  end
end
#Edit this if nessescary
debug = false
include TicTacToe
if debug
  TicTacToe.debug
else
  TicTacToe.play
end