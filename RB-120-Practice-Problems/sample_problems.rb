##### RB 120 Sample problems from gcpinckert ####

# https://github.com/gcpinckert/rb120_rb129/blob/main/study_guide/study_session_8_12.md

=begin
# Compare FishAliens

# Modify the given code to achieve the expected output

class FishAliens
  def initialize(age, name)
    @age = age
    @name = name
  end

  def ==(other)
    self.class == other.class
  end

  protected  # Protected methods defined in the superclass are inherited and accessible to subclasses.

  attr_reader :age, :name
end

class Jellyfish < FishAliens; end

class OctoAlien < FishAliens; end

fish = Jellyfish.new(100, "Fish")
alien = OctoAlien.new(75, "Roger")

                      # Expected output:
p fish == alien       # => false

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

# Dictionary

# Implement the following classes such that we get the desired output

class Dictionary
  attr_accessor :words

  def initialize
    @words = []
  end

  def <<(word)
    words << word
    words.sort!
  end

  def words
    @words.each {|word| word}
  end

  def by_letter(letter)
    words.select do |word|
      word.name.upcase[0] == letter.upcase
    end
  end

end

class Word
  include Comparable

  attr_reader :name

  def initialize(name, definition)
    @name = name
    @definition = definition
  end

  def to_s
    name
  end

  def <=>(other)
    name <=> other.name
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

puts dictionary.words # Result should be alphabetical.
# Apple
# Banana
# Blueberry
# Cherry

puts dictionary.by_letter("a")
# Apple

puts dictionary.by_letter("B")
# Banana
# Blueberry

# Library

# Given the two classes defined below, implement the necessary methods to get the expected results.

class Library
  attr_accessor :books

  def initialize
    @books = []
  end

  def <<(book)
    books << book
  end

  def checkout_book(name, auth)
    book = Book.new(name, auth)
    if books.include?(book)
      books.delete(book)
    else
      puts "The library does not have that book"
    end
  end

end

class Book
  attr_reader :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_s
    "#{title} by #{author}"
  end

  def ==(other)
    title = other.title && author == other.author
  end

end

lib = Library.new

lib << Book.new('Great Expectations', 'Charles Dickens')
lib << Book.new('Romeo and Juliet', 'William Shakespeare')
lib << Book.new('Ulysses', 'James Joyce')

lib.books.each { |book| puts book }
  # => Great Expectations by Charles Dickens
  # => Romeo and Juliet by William Shakespeare
  # => Ulysses by James Joyce

p lib.checkout_book('Romeo and Juliet', 'William Shakespeare')
  # deletes the Romeo and Juliet book object from @books and returns it
  # i.e. returns #<Book:0x0000558ee2ffcf50 @title="Romeo and Juliet", @author="William Shakespeare">

lib.books.each { |book| puts book }
  # => Great Expectations by Charles Dickens
  # => Ulysses by James Joyce

lib.checkout_book('The Odyssey', 'Homer')
  # => The library does not have that book

# Constants

LOCATION = self

class Parent
  # LOCATION = self
end

module A
  module B
    # LOCATION = self
    module C
      class Child < Parent
        # LOCATION = self
        def where_is_the_constant
          LOCATION
        end
      end
    end
  end
end

instance = A::B::C::Child.new
puts instance.where_is_the_constant

# What does the last line of code output? #=> A::B::C::Child
# Comment out LOCATION in Child, what is output now? #=> A::B
# Comment out LOCATION in Module B, what is output now? #=> Parent
# Comment out LOCATION in Parent, what is output now? #=> main

# Implement the given classes so that we get the expected results

class ClassLevel
  attr_accessor :level, :members

  def initialize(level)
    @level = level
    @members = []
  end

  def <<(student)
    if members.include?(student)
      puts "That student is already added."
    else
      members << student
    end
  end

  def valedictorian
    top = members.max_by {|student| student.gpa}
    puts "#{top.name} has the highest GPA of #{top.gpa}"
  end
end

class Student
  attr_accessor :name, :id, :gpa
  
  def initialize(name, id, gpa)
    @name = name
    @id = id
    @gpa = gpa
  end

  def ==(other)
    name == other.name && id == other.id && gpa == other.gpa
  end

  def >(other)
    gpa > other.gpa
  end

  def to_s
    <<~HEREDOC
    ===========
    Name: #{name}
    Id: #{id}
    GPA: #{gpa}
    ==========
    HEREDOC
  end
end

juniors = ClassLevel.new('Juniors')

anna_a = Student.new('Anna', '123-11-123', 3.85)
bob = Student.new('Bob', '555-44-555', 3.23)
chris = Student.new('Chris', '321-99-321', 2.98)
david = Student.new('David', '987-00-987', 3.12)
anna_b = Student.new('Anna', '543-33-543', 3.76)

juniors << anna_a
juniors << bob
juniors << chris
juniors << david
juniors << anna_b

juniors << anna_a
  # => "That student is already added"

puts juniors.members
  # => ===========
  # => Name: Anna
  # => Id: XXX-XX-123
  # => GPA: 3.85
  # => ==========
  # => ...etc (for each student)

p anna_a == anna_b 
  # => false

p david > chris
  # => true

juniors.valedictorian
  # => "Anna has the highest GPA of 3.85"

=end