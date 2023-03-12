########### RB 120 Object Oriented Programming: Lesson 5: OO 21 #########
require 'pry'
=begin
# 1. Write a description of the problem and extract major nouns and verbs.
A Short description of the game:

Twenty-One is a card game consisting of a dealer and a player, where the participants try to get as close to 21 as possible without going over.

Here is an overview of the game:
- Both participants are initially dealt 2 cards from a 52-card deck.
- The player takes the first turn, and can "hit" or "stay".
- If the player busts, he loses. If he stays, it's the dealer's turn.
- The dealer must hit until his cards add up to at least 17.
- If he busts, the player wins. If both player and dealer stays, then the highest total wins.
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

# 2. Make an initial guess at organizing the verbs into nouns and do a spike to explore the problem with temporary code.
# 3. Optional - when you have a better idea of the problem, model your thoughts into CRC cards.

=end

# Spike

class Participant
  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def total
    values = @cards.map { |card| card.val }

    sum = 0
    values.each do |val|
      case
      when val == "A"      then sum += 11
      when val.to_i == 0   then sum += 10
      else                      sum += val.to_i
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

  def hit
  end

  def stay
  end
end

class Dealer < Participant
  def initialize(name)
    super(name)

    # seems like very similar to Player... do we even need this?
  end

  def deal

  end

  def hit
  end
  
  def stay
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
  CARD_VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

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
    binding.pry
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
    2.times do |x|
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
      hand<< [card.suit + card.val]
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