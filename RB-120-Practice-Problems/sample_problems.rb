##### RB 120 Sample problems from gcpinckert ####

# https://github.com/gcpinckert/rb120_rb129/blob/main/study_guide/study_session_8_12.md

=begin

# Attack

module Attackable
  def attacks
    puts "attacks!"
  end
end


class Barbarian
  include Attackable

  def initialize(name, hitpoints)
    @name = name
    @hitpoints = hitpoints
  end
end

class Monster
  include Attackable

  def initialize(name, hitpoints)
    @name = name
    @hitpoints = hitpoints
  end
end


conan = Barbarian.new("Conan", 50)
zombie = Monster.new("Fred", 100)

conan.attacks
zombie.attacks

# We expected the code to output
#=> "attacks!"
#=> "attacks!"

#=> Instead we raise an error.  What would be the best way to fix this implementation? Why?

Add in a Attackable mixin module to both classes with a `attacks` method defined.

# Animal Sounds

# What does the above code output? How can you fix it so we get the desired results?

class Animal
  attr_reader :sound

  def initialize(name)
    @name = name
  end
  
  def speak
    puts "#{@name} says #{sound}"
  end
end

class Dog < Animal
  def initialize(name)
    super
    @sound = 'Woof Woof!'
  end
end

class Cat < Animal
  def initialize(name)
    super
    @sound = 'Meow!'
  end
end
  
fido = Dog.new('Fido')
felix = Cat.new('Felix')

                    # Expected Output:
fido.speak          # => Fido says Woof Woof!
felix.speak         # => Felix says Meow!

# Shopping Basket

# GOAL:
# Create an application that allows you to add "products" to a shopping basket.
# So define the CLASSES for each product (make 3).
# Products should have a name and a price (an integer).
# Add products to the shopping basket
# At checkout calculate total_price of ALL products.

class ShoppingBasket
  attr_reader :basket

  def initialize
    @basket = []
  end

  def <<(item)
    @basket << item
  end
end

class CheckoutDesk # Should this really be a class?
  def calculatetotal(cart)
    total = 0
    cart.basket.each do |item|
      total += item.price
    end
    total
  end
end

class Product
  attr_reader :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

class Fruit < Product; end

class Meat < Product; end

class Dairy < Product; end

f = Fruit.new('Apple', 1)
m = Meat.new('Beef', 2)
d = Dairy.new('Milk', 3)

cart = ShoppingBasket.new

cart << f
cart << m
cart << d

p cart
cashier = CheckoutDesk.new()
p cashier.calculatetotal(cart)

# Player Characters

# Without running the code, determine what the output will be.

class PlayerCharacter
  attr_reader :name, :hitpoints
  def initialize(name, hitpoints)
    @name = name
    @hitpoints = hitpoints
  end
end

class Barbarian < PlayerCharacter
  attr_reader :rage

   def initialize(name, hitpoints)
    super(name, hitpoints)
    @rage = true
   end

end

class Summoner < PlayerCharacter
  attr_reader :manapoints
 
  def initialize(name, hitpoints)
    super(name, hitpoints)
    @manapoints = 100
  end
  
end

conan = Barbarian.new("Conan", 50)
gandolf = Summoner.new("Gandolf", 25)

p conan.rage # true
p gandolf.manapoints # => 100
p gandolf.hitpoints #25

=end

# Dictionary

# Implement the following classes such that we get the desired output

class Dictionary
  def initialize
    @words = []
  end
end

class Word
  def initialize(name, definition)
    @name = name
    @definition = definition
  end
end

apple = Word.new("Apple", "The round fruit of a tree of the rose family")
banana = Word.new("Banana", "A long curved fruit which grows in clusters and has soft pulpy flesh and yellow skin when ripe")
blueberry = Word.new("Blueberry", "The small sweet blue-black edible berry of the blueberry plant")
cherry = Word.new("Cherry", "A small, round stone fruit that is typically bright or dark red")

dictionary = Dictionary.new

dictionary << apple
dictionary << banana
dictionary << cherry
dictionary << blueberry

puts dictionary.words
# Apple
# Banana
# Blueberry
# Cherry

puts dictionary.by_letter("a")
# Apple

puts dictionary.by_letter("B")
# Banana
# Blueberry