########### RB 120 Object Oriented Programming: Lesson 5 Notes #########

=begin

# RB 120 SPOT Study Session

General tips:
Run code as your going.
Being able to explain the concepts and give code examples.

Lexical Scope:
Lexically, searches the enclosing structures. Starting with the inner structure, then to the next structure.

Encapsulation:
Hiding pieces of functionality and making it unavailable to the rest of the code base.
Restricts method use to certain classes or modules.
Limiting the number of public methods.

Polymorphism:
The ability for different types of data to respond to a common interface.
Can be impletemented using duck typing and the two types of inheritance.

Implementing methods in a way that can be implemented by many different kinds of objects.

Class inheritance:
When a sub class inherits from a superclass, enableing access to the superclass's methods.
Interface inheritance is used when there a "is_a" connection.

Interface inheritance:
When a class inherits from a module using the include method. Interface inheritance enables classes to inherit from mutliple
modules, instead of being able to just inherit from 1 superclass.
Interface inheritance is used when there a "has_a" connection.

Ie:
module = Swimable (contains a method for all 'things' that can swim)

Animal (all animals can breathe, so both dog, cat and fish inherit it)
 - dog (includes Swimable)
 - cat
 - fish (includes Swimable)

Duck typing:
Objects of unrelated types would be able to respond to the same method invocation in a different
manner. Both objects would have seperately defined methods.

When ruby tries to refrence an instance variable that has not yet been initialized, it returns nil.

Code example 1:

class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name

# What is output and why?

#=> "bark! bark!  bark! bark!" # The @name instance variable is not yet initialized, so string interpolation returns nil.

Code Example 2 (Lexical scope):

module Automotive
  TIRES = 6

  class Vehicle
    TIRES = 4
  end

  class Car < Vehicle
    def num_of_tires
      TIRES
    end
  end
end

car = Automotive::Car.new
p car.num_of_tires

num_of_tires will search Car for Tires, then the module Automotive where it finds a TIRES constant, if there
was no constant in Automotive, it would then search the super class.

How Ruby searches for a constant.
1. Lexically, searches the enclosing structures. Starting with the inner structure, then to the next structure.
  ie:
   - Car class
   - Automotive module
   - Searches inheritance chain.
   - top level scope.
2. Searches inheritance chain.
3. Top level scope.

To ignore the lexical search, we can use the self.class::CONSTANT to start the search in the inheritance chain.

=end

# Nouns: Meal, items (burger, side, drink), option, cost, order, customer
# Verbs: Order, choose an option, total