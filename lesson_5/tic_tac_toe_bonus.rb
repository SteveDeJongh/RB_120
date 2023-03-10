########### RB 120 Object Oriented Programming: Lesson 5: OO Tic Tac Toe Bonus Features #########
require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select{|key| @squares[key].unmarked?}
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_one?
    !!winning_marker # relies on truhiness of return value from winning_marker
  end
  
  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end

  # return winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      if count_human_marker(@squares.values_at(*line)) == 3
        return TTTGame::HUMAN_MARKER
      elsif count_computer_marker(@squares.select{|k,_| line.include?(k)}.values) == 3
        return TTTGame::COMPUTER_MARKER
      end
    end
    nil
  end

  def reset
    (1..9).each { |x| @squares[x] = Square.new }
  end

  def draw
    puts "     |     |  "  
    puts "  #{get_square_at(1)}  |  #{get_square_at(2)}  |  #{get_square_at(3)}"
    puts "     |     |  "
    puts "-----|-----|-----"    
    puts "     |     |  "
    puts "  #{get_square_at(4)}  |  #{get_square_at(5)}  |  #{get_square_at(6)}"
    puts "     |     |  "
    puts "-----|-----|-----"
    puts "     |     |  "
    puts "  #{get_square_at(7)}  |  #{get_square_at(8)}  |  #{get_square_at(9)}"
    puts "     |     |  "
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

# Orchestration engine

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts "Wecome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  # Split into two seperate method below to avoid having to call the method with the optional argument.
  # def display_board(clear_screen: true)
  #   clear if clear_screen
  #   puts "You are #{HUMAN_MARKER}, computer is a #{COMPUTER_MARKER}."
  #   puts ""
  #   puts "     |     |  "  
  #   puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
  #   puts "     |     |  "
  #   puts "-----|-----|-----"    
  #   puts "     |     |  "
  #   puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
  #   puts "     |     |  "
  #   puts "-----|-----|-----"
  #   puts "     |     |  "
  #   puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
  #   puts "     |     |  "
  #   puts "" 
  # end

  def display_board
    puts "You are #{HUMAN_MARKER}, computer is a #{COMPUTER_MARKER}."
    puts ""
    board.draw
    puts "" 
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Chooce a square (#{board.unmarked_keys.join(', ')}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board.set_square_at(square, human.marker)
  end

  def computer_moves
    board.set_square_at(board.unmarked_keys.sample, computer.marker)
  end

  def display_result
    display_board
    case board.winning_marker
    when HUMAN_MARKER
      puts "You won!"
    when COMPUTER_MARKER
      puts "Computer won!"
    else
      puts "The board is full!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y' # Returns true if answer is "y"
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def play
    clear
    display_welcome_message

    loop do #Play again loop
      display_board

      loop do # Game Turns
        human_moves
        break if board.someone_one? || board.full?
        computer_moves
        break if board.someone_one? || board.full?
        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end

    display_goodbye_message
  end
end

# Kick off the game like so:
game = TTTGame.new
game.play