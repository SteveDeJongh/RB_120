########### RB 120 Object Oriented Programming: Lesson 5: OO 21 #########
require 'pry'
=begin
# 1. Write a description of the problem and extract major nouns and verbs.
A Short description of the game:

Twenty-One is a card game consisting of a dealer and a player, where the
 participants try to get as close to 21 as possible without going over.

Here is an overview of the game:
- Both participants are initially dealt 2 cards from a 52-card deck.
- The player takes the first turn, and can "hit" or "stay".
- If the player busts, he loses. If he stays, it's the dealer's turn.
- The dealer must hit until his cards add up to at least 17.
- If he busts, the player wins. If both player and dealer stays, then the
 highest total wins.
- If both totals are equal, then it's a tie, and nobody wins.

The nouns and verbs are:
Nouns: card, player, dealer, participant, deck, game, total
Verbs: deal, hit, stay, busts

Player
- hit
- stay
- busted?
- total
Dealer
- hit
- stay
- busted?
- total
- Deal (should this be here, or in Deck?)
Participant
Deck
- Deal (should thi sbe here, or in Dealer?)
Card
Game
- Start

# 2. Make an initial guess at organizing the verbs into nouns and do a spike to
 explore the problem with temporary code.
# 3. Optional - when you have a better idea of the problem, model your thoughts
 into CRC cards.

=end

# Spike

class Participant
  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def total
    values = @cards.map(&:val)

    sum = 0
    values.each do |val|
      if val == "A"
        sum += 11
      elsif val.to_i == 0
        sum += 10
      else
        sum += val.to_i
      end
    end

    values.select { |value| value == "A" }.count.times do
      sum -= 10 if sum > 21
    end
    sum
  end

  def busted?
    total > 21
  end
end

class Player < Participant
  def initialize(name)
    super(name)
    # What would the data or state of a player object entail?
    # maybe cards? a name?
  end
end

class Dealer < Participant
  def initialize(name)
    super(name)

    # seems like very similar to Player... do we even need this?
  end
end

class Deck
  attr_accessor :deck

  def initialize
    # obviously we need some data structure to kep track of cards
    # array, hash, something else?
    @deck = []
    initialize_deck
  end

  def deal
    deck.delete(deck.sample)
  end

  def initialize_deck
    Card::CARD_SUITS.each do |suit|
      Card::CARD_VALUES.each do |val|
        @deck << Card.new(suit, val)
      end
    end
  end
end

class Card
  attr_reader :val, :suit

  CARD_SUITS = ['H', 'D', 'C', 'S']
  CARD_VALUES = ['2', '3', '4', '5', '6', '7', '8'] +
                ['9', '10', 'J', 'Q', 'K', 'A']

  def initialize(suit, val)
    # what are the 'states' of a card?
    @suit = suit
    @val = val
  end
end

class Game
  attr_accessor :deck

  def start
    # what's the sequence of steps to execute the game play?
    display_welcome_message
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end

  def initialize
    @deck = Deck.new
    @human = Player.new('Steve')
    @dealer = Dealer.new('Dealer')
  end

  def display_welcome_message
    puts "Welcome to 21!"
    puts "Closest to 21 wins, dealer hits if cards are less than 17."
  end

  def deal_cards
    2.times do |_|
      @human.cards << deck.deal
      @dealer.cards << deck.deal
    end
  end

  def show_initial_cards
    player_display = build_hand(@human)
    dealer_display = build_hand(@dealer)
    dealer_display[0] = ['Hidden']
    puts "Player cards: #{player_display.join(',')}, for a total of #{@human.total}."
    puts "Dealer cards: #{dealer_display.join(',')}."
  end

  def show_cards
    player_display = build_hand(@human)
    dealer_display = build_hand(@dealer)
    puts "Player cards: #{player_display.join(',')}, for a total of #{@human.total}."
    puts "Dealer cards: #{dealer_display.join(',')}, for a total of #{@dealer.total}."
  end

  def build_hand(player)
    hand = []
    player.cards.each do |card|
      hand << [card.suit + card.val]
    end
    hand
  end

  def player_turn
    loop do
      answer = nil
      loop do
        puts "Would you like to hit or stay?"
        answer = gets.chomp.downcase
        break if ['h', 's'].include?(answer)
        puts "Please enter a valid move."
      end
      if answer[0] == 'h'
        @human.cards << deck.deal
        puts "You chose to hit!"
        show_initial_cards
      end
      puts @human.busted? ? "Player goes bust!" : ""
      break if answer[0] == 's' || @human.busted?
    end
  end

  def dealer_turn
    total = @dealer.total
    loop do
      break if total >= 17
      @dealer.cards << deck.deal
      total = @dealer.total
    end

    puts @dealer.busted? ? "Dealer goes bust!" : "Dealer chose to stay at #{total}."
  end

  def determine_winner
    player_total = @human.total
    dealer_total = @dealer.total
    if player_total > 21
      :player_busted
    elsif dealer_total > 21
      :dealer_busted
    elsif dealer_total < player_total
      :player
    elsif dealer_total > player_total
      :dealer
    else
      :tie
    end
  end

  def show_result
    puts ""
    show_cards
    puts ""
    display_result
  end

  def display_result
    result = determine_winner
    case result
    when :player_busted
      puts "You busted! Dealer wins!"
    when :dealer_busted
      puts "Dealer busted! You win!"
    when :player
      puts "You win!"
    when :dealer
      puts "Dealer wins!"
    when :tie
      puts "It's a tie!"
    end
  end
end

Game.new.start

# LS Implementation

=begin

class Card
  SUITS = ['H', 'D', 'S', 'C']
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "The #{face} of #{suit}"
  end

  def face
    case @face
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else
      @face
    end
  end

  def suit
    case @suit
    when 'H' then 'Hearts'
    when 'D' then 'Diamonds'
    when 'S' then 'Spades'
    when 'C' then 'Clubs'
    end
  end

  def ace?
    face == 'Ace'
  end

  def king?
    face == 'King'
  end

  def queen?
    face == 'Queen'
  end

  def jack?
    face == 'Jack'
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        @cards << Card.new(suit, face)
      end
    end

    scramble!
  end

  def scramble!
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end
end

module Hand
  def show_hand
    puts "---- #{name}'s Hand ----"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
    puts ""
  end

  def total
    total = 0
    cards.each do |card|
      if card.ace?
        total += 11
      elsif card.jack? || card.queen? || card.king?
        total += 10
      else
        total += card.face.to_i
      end
    end

    # correct for Aces
    cards.select(&:ace?).count.times do
      break if total <= 21
      total -= 10
    end

    total
  end

  def add_card(new_card)
    cards << new_card
  end

  def busted?
    total > 21
  end
end

class Participant
  include Hand

  attr_accessor :name, :cards
  def initialize
    @cards = []
    set_name
  end
end

class Player < Participant
  def set_name
    name = ''
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, must enter a value."
    end
    self.name = name
  end

  def show_flop
    show_hand
  end
end

class Dealer < Participant
  ROBOTS = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']

  def set_name
    self.name = ROBOTS.sample
  end

  def show_flop
    puts "---- #{name}'s Hand ----"
    puts "#{cards.first}"
    puts " ?? "
    puts ""
  end
end

class TwentyOne
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def reset
    self.deck = Deck.new
    player.cards = []
    dealer.cards = []
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal_one)
      dealer.add_card(deck.deal_one)
    end
  end

  def show_flop
    player.show_flop
    dealer.show_flop
  end

  def player_turn
    puts "#{player.name}'s turn..."

    loop do
      puts "Would you like to (h)it or (s)tay?"
      answer = nil
      loop do
        answer = gets.chomp.downcase
        break if ['h', 's'].include?(answer)
        puts "Sorry, must enter 'h' or 's'."
      end

      if answer == 's'
        puts "#{player.name} stays!"
        break
      elsif player.busted?
        break
      else
        # show update only for hit
        player.add_card(deck.deal_one)
        puts "#{player.name} hits!"
        player.show_hand
        break if player.busted?
      end
    end
  end

  def dealer_turn
    puts "#{dealer.name}'s turn..."

    loop do
      if dealer.total >= 17 && !dealer.busted?
        puts "#{dealer.name} stays!"
        break
      elsif dealer.busted?
        break
      else
        puts "#{dealer.name} hits!"
        dealer.add_card(deck.deal_one)
      end
    end
  end

  def show_busted
    if player.busted?
      puts "It looks like #{player.name} busted! #{dealer.name} wins!"
    elsif dealer.busted?
      puts "It looks like #{dealer.name} busted! #{player.name} wins!"
    end
  end

  def show_cards
    player.show_hand
    dealer.show_hand
  end

  def show_result
    if player.total > dealer.total
      puts "It looks like #{player.name} wins!"
    elsif player.total < dealer.total
      puts "It looks like #{dealer.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def start
    loop do
      system 'clear'
      deal_cards
      show_flop

      player_turn
      if player.busted?
        show_busted
        if play_again?
          reset
          next
        else
          break
        end
      end

      dealer_turn
      if dealer.busted?
        show_busted
        if play_again?
          reset
          next
        else
          break
        end
      end

      # both stayed
      show_cards
      show_result
      play_again? ? reset : break
    end

    puts "Thank you for playing Twenty-One. Goodbye!"
  end
end

game = TwentyOne.new
game.start

=end
