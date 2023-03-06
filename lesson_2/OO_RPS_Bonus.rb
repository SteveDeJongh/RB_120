#### RB 120 OO RPS Bonus Features #####

class Player
  attr_accessor :move, :name, :score, :moves

  def initialize
    set_name
    @score = 0
    @moves = {'rock' => 0,
              'paper' => 0,
              'scissors' => 0,
              'lizard' => 0,
              'spock' => 0}
  end

  def display_moves
    player = name
    output = "
    ------ #{player}'s Move History: ------
    #{player} called rock #{moves['rock']} times.
    #{player} called paper #{moves['paper']} times.
    #{player} called scissors #{moves['scissors']} times.
    #{player} called lizard #{moves['lizard']} times.
    #{player} called spock #{moves['spock']} times.
    "
    puts output
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, spock or lizard:"
      choice = gets.chomp
      self.moves[choice] += 1 if self.moves.key?(choice)
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'spock', 'lizard']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def spock?
    @value == 'spock'
  end

  def lizard?
    @value =='lizard'
  end

  def >(other_move)
    (scissors? && other_move.paper?) ||
    (paper? && other_move.rock?) ||
    (rock? && other_move.lizard?) ||
    (lizard? && other_move.spock?) ||
    (spock? && other_move.scissors?) ||
    (scissors? && other_move.lizard?) ||
    (lizard? && other_move.paper?) ||
    (paper? && other_move.spock?) ||
    (spock? && other_move.rock?) ||
    (rock? && other_move.scissors?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?) ||
      (lizard? && other_move.rock?) ||
      (spock? && other_move.lizard?) ||
      (scissors? && other_move.spock?) ||
      (lizard? && other_move.scissors?) ||
      (paper? && other_move.lizard?) ||
      (spock? && other_move.paper?) ||
      (rock? && other_move.spock?)
  end

  def to_s
    @value
  end
end

# Game Orchestration Engine

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, lizard, spock. Good Bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def keep_score
    if human.move > computer.move
      @human.score += 1
    elsif human.move < computer.move
      @computer.score += 1
    end
  end

  def display_score
    puts "#{human.name} #{human.score} vs #{computer.name} #{computer.score}"
    puts "First to 3!"
  end

  def winner?
    true if human.score >= 3 || computer.score >= 3
  end

  def reset_scores
    @human.score = 0
    @computer.score = 0
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return true if answer.downcase == 'y'
    return false if answer.downcase == 'n'
  end

  def play
    display_welcome_message
    loop do # Game loop
      loop do # Best of 3 loop
        human.choose
        computer.choose
        display_moves
        display_winner
        human.display_moves
        keep_score
        display_score
        break if winner?
      end
      reset_scores
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
