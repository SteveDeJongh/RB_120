#### RB120 Object Oritented Programming: Medium 1 ####
require 'pry'
=begin

# 1) Privacy

# Consider the following class:

class Machine
  def initialize(switch)
    @switch = switch
  end

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def switch_position
    "My switch position is #{switch}."
  end

  private

  attr_reader :switch # FE
  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

# Modify this class so both flip_switch and the setter method switch= are private methods.

# FE Add a private getter for @switch to the Machine class, and add a method to Machine that shows how to use that getter.

m1 = Machine.new(:on)
p m1
p m1.switch_position
# p m1.switch # raises an error, `switch` it a private method.
m1.stop # Turns switch to :off.
p m1.switch_position

# 2) Fixed Array

# A fixed-length array is an array that always has a fixed number of elements. Write a class that implements
#  a fixed-length array, and provides the necessary methods to support the following code:

class FixedArray
  # attr_accessor :array

  def initialize(size) # initialize object with an array of `nil`s the size of `size`
    @array = [nil] * size # Or @array = Array.new(size)
  end

  def [](num) # Getter method
    @array.fetch(num) # Important to use fetch as element reference would return `nil` for out of bounds indexes.
  end

  def []=(index, value) # Setter method
    self[index] # raises an error if index is invalid.
    @array[index] = value
  end

  def to_a # output instance variable @array when called
    @array.clone # Returning a close of the array so that any changes don't affect the instance variable.
  end

  def to_s # Output the instance variable @array as a string when called.
    to_a.to_s
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end

# 3) Students

# Below we have 3 classes: Student, Graduate, and Undergraduate. The implementation details for
# the #initialize methods in Graduate and Undergraduate are missing. Fill in those missing details
# so that the following requirements are fulfilled:

# Graduate students have the option to use on-campus parking, while Undergraduate students do not.

# Graduate and Undergraduate students both have a name and year associated with them.

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end

# FE highlights how `Super()` can be used.

# 4) Circular Queue

class CircularQueue
  def initialize(size)
    @buffer = Array.new(size)
    @next_position = 0
    @oldest_position = 0
  end

  def enqueue(obj) # To add an object to the queue
    unless @buffer[@next_position].nil?
      @oldest_position = increment(@next_position)
    end

    @buffer[@next_position] = obj
    @next_position = increment(@next_position)
  end

  def dequeue # To remove an object from the queue
    value = @buffer[@oldest_position]
    @buffer[@oldest_position] = nil
    @oldest_position = increment(@oldest_position) unless value.nil?
    value
  end

  private

  def increment(position) # Method used to "Wrap around" back to index 0.
    (position + 1) % @buffer.size
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)

puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

# Using Shift and push

class CircularQueue
  attr_reader :queue

  def initialize(num_spots)
    @queue = []
    @buffer_length = num_spots # Track max size of array
  end

  def dequeue
    return nil if queue.empty? # returns nil if there are no element to remove
    queue.shift # returns the element removed from array
  end

  def enqueue(element)
    dequeue if queue.size == @buffer_length # removes oldest (first) element from the array if attempting to add an object passed max size
    queue.push(element) # Adds new object to end (newist) of array.
  end
end


# 5) Stack Machine Interpretation # Revisit and explore FE

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  ACTIONS = %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(operations)
    @ops = operations.split
  end

  def eval
    @stack = []
    @register = 0
    @ops.each {|step| eval_token(step)}
  rescue MinilangError => error
    puts error.message
  end

  private

  def eval_token(token)
    if ACTIONS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      @register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
  end

  def push
    @stack << @register
  end

  def add
    @register += @stack.pop
  end

  def sub
    @register -= @stack.pop
  end

  def mult
    @register = @register * @stack.pop
  end

  def div
    @register = (@register / @stack.pop).to_i
  end

  def mod
    @register = (@register % @stack.pop).to_i
  end

  def pop
    raise EmptyStackError, 'Empty stack!' if @stack.empty?
    @register = @stack.pop
  end

  def print
    puts @register
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

# 6) Number Guesser Part 1

class GuessingGame1
  def initialize
    @guesses = 7
    @number = rand(1..100)
  end

  def play
    loop do
      player_pick
      high_or_low
      winner?
      break if @guesses == 1 || winner?
      @guesses -= 1
    end
    game_end
    reset
  end

  def player_pick
    @input = ""
    loop do
      puts "Enter a number between 1 and 100:"
      @input = gets.chomp.to_i
      break if (1..100).include?(@input)
      puts "Invalid guess. Enter a number between 1 and 100:"
    end
    @input.to_i
  end

  def high_or_low
    if @input < @number
      puts "Your guess is too low."
    elsif @input > @number
      puts "Your guess it too high."
    end
  end

  def winner?
    if @input == @number
      puts "That's the number!"
    else
      false
    end
  end

  def game_end
    if winner?
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end
  
  def reset
    @guesses = 7
    @number = rand(1..100)
  end

end

game1 = GuessingGame1.new
# game.play
# game.play

class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100

  RESULT_OF_GUESS_MESSAGE = {
    high: "Your number is too high.",
    low: "Your number is too low.",
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high: :lose,
    low: :lose,
    match: :win
  }.freeze

  RESULT_OF_GAME_MESSAGE = {
    win: "You won!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  def initialize
    @secret_number = nil
  end

  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(RANGE)
  end

  def play_game
    result = nil
    MAX_GUESSES.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def obtain_one_guess
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      guess = gets.chomp.to_i
      return guess if RANGE.cover?(guess)
      print "Invalid Guess. "
    end
  end

  def check_guess(guess_value)
    return :match if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def display_game_end_message(result)
    puts "" , RESULT_OF_GAME_MESSAGE[result]
  end
end

game = GuessingGame.new
game.play

# 7) Number Guesser Part 2

class GuessingGame
  RESULT_OF_GUESS_MESSAGE = {
    high: "Your number is too high.",
    low: "Your number is too low.",
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high: :lose,
    low: :lose,
    match: :win
  }.freeze

  RESULT_OF_GAME_MESSAGE = {
    win: "You won!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  def initialize(low, high)
    @range = (low..high)
    @guesses = Math.log2(@range.size).to_i + 1
    @secret_number = nil
  end

  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(@range)
  end

  def play_game
    result = nil
    binding.pry
    @guesses.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def obtain_one_guess
    loop do
      print "Enter a number between #{@range.first} and #{@range.last}: "
      guess = gets.chomp.to_i
      return guess if @range.cover?(guess)
      print "Invalid Guess. "
    end
  end

  def check_guess(guess_value)
    return :match if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def display_game_end_message(result)
    puts "" , RESULT_OF_GAME_MESSAGE[result]
  end
end

game = GuessingGame.new(1, 100)
game.play

# 8) Highest and Lowest Ranking Cards

class Card
  include Comparable

  attr_reader :rank, :suit
  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  SUITS = { 'Spades' => 0.4, 'Hearts' => 0.3, 'Clubs' => 0.2, 'Diamonds' => 0.1} #using floats to avoid x of Spades being > x+1 of diamonds.

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    score <=> other.score
  end

  def score
    # case self.rank
    # when "Ace"   then 14
    # when "King"  then 13
    # when "Queen" then 12
    # when "Jack"  then 11
    # else              self.rank
    # end

    #Could also use a hash and fetch with default values.
    VALUES.fetch(rank, rank) + SUITS.fetch(suit) # FE to add score of the suit as well.
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

# cards = [Card.new(2, 'Hearts'),
#   Card.new(10, 'Diamonds'),
#   Card.new('Ace', 'Clubs')]
# puts cards
# puts cards.min
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')

# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts')
# puts cards.max == Card.new(5, 'Hearts')

# cards = [Card.new(4, 'Hearts'),
#   Card.new(4, 'Diamonds'),
#   Card.new(10, 'Clubs')]
# puts cards.min.rank == 4
# puts cards.max == Card.new(10, 'Clubs')

# cards = [Card.new(7, 'Diamonds'),
#   Card.new('Jack', 'Diamonds'),
#   Card.new('Jack', 'Spades')]
# puts cards.min == Card.new(7, 'Diamonds')
# puts cards.max.rank == 'Jack'

# cards = [Card.new(8, 'Diamonds'),
#   Card.new(8, 'Clubs'),
#   Card.new(8, 'Spades')]
# puts cards.min.rank == 8
# puts cards.max.rank == 8

cards = [Card.new(5, 'Diamonds'),
  Card.new(4, 'Diamonds'),
  Card.new(4, 'Spades')]

p cards.min
p cards.max

# 9) Deck of Cards

class Card
  include Comparable

  attr_reader :rank, :suit
  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  # SUITS = { 'Spades' => 0.4, 'Hearts' => 0.3, 'Clubs' => 0.2, 'Diamonds' => 0.1} #using floats to avoid x of Spades being > x+1 of diamonds.

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    score <=> other.score
  end

  def score
    # case self.rank
    # when "Ace"   then 14
    # when "King"  then 13
    # when "Queen" then 12
    # when "Jack"  then 11
    # else              self.rank
    # end

    #Could also use a hash and fetch with default values.
    VALUES.fetch(rank, rank) #+ SUITS.fetch(suit) # FE to add score of the suit as well.
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map {|x, y| Card.new(x, y) }.shuffle
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
# p drawn
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.


=end

# 10) Poker!