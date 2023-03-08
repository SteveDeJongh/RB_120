################################## RB 120 Lesson 3 ########################################

########################################################################
################################## Equivalence #########################
########################################################################

# #comparing string, integer, and symbols.
# str1 = "something"
# str2 = "something"
# p str1 == str2            # => true

# int1 = 1
# int2 = 1
# p int1 == int2            # => true

# sym1 = :something
# sym2 = :something
# p sym1 == sym2            # => true

# str1 = "something"
# str2 = "something"
# str1_copy = str1

# # comparing the string objects' values
# str1 == str2            # => true
# str1 == str1_copy       # => true
# str2 == str1_copy       # => true

# # comparing the actual objects
# str1.equal? str2        # => false
# str1.equal? str1_copy   # => true
# str2.equal? str1_copy   # => false

# #Example of having to define a `==` method for a new class.

# class Person
#   attr_accessor :name
# end

# bob = Person.new
# bob.name = "bob"

# bob2 = Person.new
# bob2.name = "bob"

# bob == bob2                # => false

# bob_copy = bob
# bob == bob_copy            # => true

# # Above demonstrate behavior of `==` behaving the same as `equal?`, but what we actually want to compare is the
# # values of the `name` instance variables of each `person` object.

# class Person
#   attr_accessor :name

#   def ==(other)
#     name == other.name     # relying on String#== here
#   end
# end

# bob = Person.new
# bob.name = "bob"

# bob2 = Person.new
# bob2.name = "bob"

# bob == bob2                # => true

# # We override the `basicobject` `==` method by defining our own in `person`.

########################################################################
################################## Variable Scope #########################
########################################################################

# Instance Variable Scope

# class Person
#   def initialize(n)
#     @name = n
#   end

#   def get_name
#     @name                     # is the @name instance variable accessible here?
#   end
# end

# bob = Person.new('bob')
# bob.get_name                  # => "bob"

# # Class Variable Scope

# class Person
#   @@total_people = 0            # initialized at the class level

#   def self.total_people
#     @@total_people              # accessible from class method
#   end

#   def initialize
#     @@total_people += 1         # reassigned from instance method
#   end

#   def total_people
#     @@total_people              # accessible from instance method
#   end
# end

# Person.total_people             # => 0
# Person.new
# Person.new
# Person.total_people             # => 2

# bob = Person.new
# bob.total_people                # => 3

# joe = Person.new
# joe.total_people                # => 4

# Person.total_people             # => 4

# Constants Variable Scope

# class Computer
#   GREETINGS = ["Beep", "Boop"]
# end

# # class Person
# #   def self.greetings
# #     GREETINGS.join(', ')
# #   end

# #   def greet
# #     GREETINGS.sample
# #   end
# # end

# # puts Person.greetings # => NameError
# # puts Person.new.greet # => NameError

# class Person
#   def self.greetings
#     Computer::GREETINGS.join(', ')
#   end

#   def greet
#     Computer::GREETINGS.sample
#   end
# end

# puts Person.greetings # => Beep, Boop
# puts Person.new.greet # => Beep or Boop

########################################################################
############### Inheritance and Variable Scope #########################
########################################################################

# # Instance variables:

# class Animal
#   def initialize(name)
#     @name = name
#   end
# end

# class Dog < Animal
#   def dog_name
#     "bark! bark! #{@name} bark! bark!"    # can @name be referenced here?
#   end
# end

# teddy = Dog.new("Teddy")
# puts teddy.dog_name                       # => bark! bark! Teddy bark! bark!

# #Works at Dog is a subclass of Animal, and @name is initialize in the superclass `initialize` method.

# class Animal
#   def initialize(name)
#     @name = name
#   end
# end

# class Dog < Animal
#   def initialize(name); end

#   def dog_name
#     "bark! bark! #{@name} bark! bark!"    # can @name be referenced here?
#   end
# end

# teddy = Dog.new("Teddy")
# puts teddy.dog_name                       # => bark! bark!  bark! bark!

# # @name is nil, as @name is not initialized in the `dog` intialize method.

# # Mixin modules.

# module Swim
#   def enable_swimming
#     @can_swim = true
#   end
# end

# class Dog
#   include Swim

#   def swim
#     "swimming!" if @can_swim
#   end
# end

# teddy = Dog.new
# teddy.swim                                  # => nil

# # @can_swim is `nil` as `enable_swimming` was never called.

# teddy = Dog.new
# teddy.enable_swimming
# teddy.swim                                  # => swimming!

# # Assuming the same module and class from above, @can_swim is now initialized and availalbe after the enable_swimming
# # call.

# # Class variable:

# class Animal
#   @@total_animals = 0

#   def initialize
#     @@total_animals += 1
#   end
# end

# class Dog < Animal
#   def total_animals
#     @@total_animals
#   end
# end

# spike = Dog.new
# spike.total_animals                           # => 1

# # Class variables are available in sub-classes. As the class varialbe is intialized in the `Animal` class, there
# # is no method to explicitly invoke to initialize it. The class variable is loaded when the class is evaluated by
# # ruby.

# class Vehicle
#   @@wheels = 4

#   def self.wheels
#     @@wheels
#   end
# end

# Vehicle.wheels                              # => 4

# # intiailized a class with @@wheels and 4

# class Motorcycle < Vehicle
#   @@wheels = 2
# end

# Motorcycle.wheels                           # => 2
# Vehicle.wheels                              # => 2  Yikes!

# # subclass vehicle by Motorcycle. The reassignment of @@hweels will affect the supper class, and all other
# # subclasses of vehicle.

# # Constants

# module FourWheeler
#   WHEELS = 4
# end

# class Vehicle
#   # include FourWheeler # Needed for "puts car.maintenance" to have access to WHEELS
#   def maintenance
#     "Changing #{WHEELS} tires."
#   end
# end

# class Car < Vehicle
#   include FourWheeler

#   def wheels
#     WHEELS
#   end
# end

# car = Car.new
# puts car.wheels        # => 4
# puts car.maintenance   # => NameError: uninitialized constant Vehicle::WHEELS

# # NameError is due to the lexical scope of the reference
# # Loop up path for #Car.maintenance constant WHEELS is vehicle < object ...
# # Loop up path for #Car.wheels constnat WHEELS is car < FourWheeler < Vehicle ...

# class Vehicle
#   WHEELS = 4
# end

# WHEELS = 6

# class Car < Vehicle
#   def wheels
#     WHEELS
#   end
# end

# car = Car.new
# puts car.wheels        # => 4

# # Lexical scope does not include the main scope.

########################################################################
############### Fake Operators #########################################
########################################################################

# Element setter and getter methods, custom plus, custom push, Comparison.
=begin
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person) # Defined comparison method.
    age > other_person.age
  end
end

class Team
  attr_accessor :name, :members
  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person) # Redefined push method.
    members.push person
  end

  def +(other_team) # Redefined plus method.
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end

  def [](idx) # Redefined getter method.
    members[idx]
  end

  def []=(idx, obj) # Redefined setter method.
    members[idx] = obj
  end
end

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)


niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)
niners << Person.new("Deion Sanders", 47)

dream_team = cowboys + niners
dream_team.name = "Dream Team"

dream_team[4]
dream_team[5] = Person.new("JJ", 72)

puts dream_team.inspect
=end