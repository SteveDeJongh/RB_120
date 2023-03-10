# RB 120 Object Oriented Programming: Lesson 5: OO Tic Tac Toe Bonus Features #
require 'pry'
class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def unmarked_keys_string
    arr = unmarked_keys
    case arr.size
    when 0 then ''
    when 1 then arr.first.to_s
    when 2 then arr.join(" or ")
    else
      arr[-1] = "or #{arr.last}"
      arr.join(', ')
    end
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_one?
    !!winning_marker # relies on truhiness of return value from winning_marker
  end

  # return winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |x| @squares[x] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |  "
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |  "
    puts "-----|-----|-----"
    puts "     |     |  "
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |  "
    puts "-----|-----|-----"
    puts "     |     |  "
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |  "
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def [](idx)
    @squares[idx].marker
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
    # This is just checking if all markers are the same. Could also
    # do markers.uniq.size == 1, or ...
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

  def marked?
    marker != INITIAL_MARKER
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
  FIRST_TO_MOVE = HUMAN_MARKER
  attr_reader :board, :human, :computer, :human_score, :computer_score

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
    @human_score = 0
    @computer_score = 0
  end

  def play # Game Loop
    clear
    display_welcome_message
    main_game # round loop.
    display_goodbye_message
  end

  private

  def main_game
    loop do # Play again loop
      best_of_3
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def best_of_3
    loop do
      display_board
      player_move # Game Turns
      keep_score
      display_result
      board.reset
      break if human_score == 3 || computer_score == 3
    end
  end

  def player_move
    loop do # Game Turns
      current_player_moves
      break if board.someone_one? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def display_welcome_message
    puts "Wecome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You are #{HUMAN_MARKER}, computer is a #{COMPUTER_MARKER}."
    display_game_score
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Chooce a square (#{board.unmarked_keys_string}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    # board.set_square_at(square, human.marker)
    board[square] = human.marker
  end

  def computer_moves # Attacks first, defence, middle, then randomn.
    mark = find_winning_play
    mark = find_at_risk_square unless !mark.nil?
    mark = 5 unless board[5] != Square::INITIAL_MARKER || !mark.nil?
    mark = board.unmarked_keys.sample unless !mark.nil?
    board[mark] = COMPUTER_MARKER
  end

  def find_at_risk_square # Computer defence.
    move = nil
    Board::WINNING_LINES.each do |line|
      if board.squares.values_at(*line).count { |x| x.to_s == HUMAN_MARKER } == 2
        move = board.squares.select { |k, v| line.include?(k) && v.to_s == Square::INITIAL_MARKER }.keys.first
        break if !mark.nil?
      end
    end
    move
  end

  def find_winning_play # Computer offence.
    move = nil
    Board::WINNING_LINES.each do |line|
      if board.squares.values_at(*line).count { |x| x.to_s == COMPUTER_MARKER } == 2
        move = board.squares.select { |k, v| line.include?(k) && v.to_s == Square::INITIAL_MARKER }.keys.first
        break if !move.nil?
      end
    end
    move
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
    display_game_score
  end

  def display_game_score
    puts "Human: #{human_score}, Computer: #{computer_score}, first to 3!"
  end

  def keep_score
    case board.winning_marker
    when HUMAN_MARKER
      @human_score += 1
    when COMPUTER_MARKER
      @computer_score += 1
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
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end
end

# Kick off the game like so:
game = TTTGame.new
game.play
