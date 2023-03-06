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