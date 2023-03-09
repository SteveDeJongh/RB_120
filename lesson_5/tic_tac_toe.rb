########### RB 120 Object Oriented Programming: Lesson 5: OO Tic Tac Toe #########
require 'pry'
=begin
1. Write a description of the problem and extract the major nouns and verbs.

Nouns and Verbs:

Tic tac toe is a 2-player voard game played ona  2x2 grid. Players take turns marking a square.
The first player to mark 3 squares in a row wins.

Nouns: Board, player, square, grid
Verbs: play, mark

Oragnized:
Board (grid)
Square
Player
 -mark
 -play

Spike:

class Board
  def initialize
    # we need some way to model a 3x3 grid. Maybe `squares`?
    # what data structure should we use?
    # - Array/hash of square objects?
    # - array/hash of strings or integers?
  end
end

class Square
  def initialize
    # maybe a "status" to keep track of this square's mark?
  end
end

class Player
  def initialize
    # maybee a `marker` to keep track of this player's symbol (ie, 'X', or 'O')
  end

  def mark
  end

  def play # This should be removed if we have a TTTGame `play`
  end
end

# Orchestration engine

class TTTGame
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

# Kick of the game like so:
game = TTTGame.new
game.play

2. Make an initial guess at organizing the verbs into nouns and do a spike to explore the problem with temporary code.
3. Optional - when you have a better idea of the problem, model your thoughts into CRC cards.
=end

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
    !!detect_winner # relies on truhiness of return value from detect_winner
  end
  
  def count_human_marker(squares)
    squares.collect(&:marker).count(TTTGame::HUMAN_MARKER)
  end

  def count_computer_marker(squares)
    squares.collect(&:marker).count(TTTGame::COMPUTER_MARKER)
  end

  # return winning marker or nil
  def detect_winner
    WINNING_LINES.each do |line|
      # binding.pry
      if count_human_marker(@squares.values_at(*line)) == 3
        return TTTGame::HUMAN_MARKER
      elsif count_computer_marker(@squares.select{|k,_| line.include?(k)}.values) == 3
        return TTTGame::COMPUTER_MARKER
      end
    end

      # Refactored into above.
      # if @squares[line[0]].marker == TTTGame::HUMAN_MARKER && @squares[line[1]].marker == TTTGame::HUMAN_MARKER &&
      #   @squares[line[2]].marker == TTTGame::HUMAN_MARKER
      #   return TTTGame::HUMAN_MARKER
      # elsif @squares[line[0]].marker == TTTGame::COMPUTER_MARKER && @squares[line[1]].marker == TTTGame::COMPUTER_MARKER &&
      #   @squares[line[2]].marker == TTTGame::COMPUTER_MARKER
      #   return TTTGame::COMPUTER_MARKER
      # end
    # end
    nil
  end

  def reset
    (1..9).each { |x| @squares[x] = Square.new }
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

  def display_board(clear = true)
    system('clear') if clear
    puts "You are #{HUMAN_MARKER}, computer is a #{COMPUTER_MARKER}."
    puts ""
    puts "     |     |  "  
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |  "
    puts "-----|-----|-----"    
    puts "     |     |  "
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |  "
    puts "-----|-----|-----"
    puts "     |     |  "
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |  "
    puts "" 
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
    case board.detect_winner
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

  def play
    system 'clear'
    display_welcome_message

    loop do #Play again loop
      display_board(false)

      loop do # Game Turns
        human_moves
        break if board.someone_one? || board.full?
        computer_moves
        break if board.someone_one? || board.full?
        display_board
      end
      display_result
      break unless play_again?
      board.reset
      system 'clear'
      puts "Let's play again!"
    end

    display_goodbye_message
  end
end

# Kick off the game like so:
game = TTTGame.new
game.play