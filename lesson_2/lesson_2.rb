#### RB 120 Lesson 2 #####

=begin
##############################################################################
########################## Lecture: Classes and Ojects #######################
##############################################################################
# 1. Given the below usage of the Person class, code the class definition.

class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end

bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'

# 2. Modify the class definition from above to facilitate the following methods.
#  Note that there is no name= setter method now.

class Person
  attr_accessor :first_name, :last_name

  def initialize(firstname, lastname='')
    @first_name = firstname
    @last_name = lastname
  end

  def name
    (@first_name + " " + @last_name).strip
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

# 3. Now create a smart name= method that can take just a first name or a full name, 
# and knows how to set the first_name and last_name appropriately.

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    (@first_name + " " + @last_name).strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  private
  
  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ""
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

p bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

# 4. Using the class definition from step #3, let's create a few more people -- that is, Person objects.

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

# If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?

p bob.name == rob.name

# 5. Continuing with our Person class definition, what does the below code print out?

class Person
  ...

  def to_s # added
    name
  end

  ...
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# This output The person's name is: <Person:0x000232....
# This is due to string interpolation calling Object#"to_s". To avoid returning the object id, we can use concatenation, or
# define a "to_s" method in our class.

##############################################################################
########################## Lecture: Inheritance ##############################
##############################################################################

# 1)

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "Can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

karl = Bulldog.new
puts karl.speak #=> "bark!"
puts karl.swim #=> "Can't swim!"

# 2)

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    "Can't swim!"
  end
end

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

p pete.run                # => "running!"
# p pete.speak              # => NoMethodError

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"
# p kitty.fetch             # => NoMethodError

p dave.speak              # => "bark!"

p bud.run                 # => "running!"
p bud.swim                # => "can't swim!"

# 3)

Bulldog (swim) < dog (speak, fetch, swim) < pet (run, jump)
Cat (speak) < pet(run, jump)
Dog (speak, fetch, swim < pet (run, jump)

# 4)

Bulldog.ancestors #=> Bulldog, Dog, Pet, Object, Kernel, BasicObject

##############################################################################
################### Lecture: Polymorphism and Ecapsulation ###################
##############################################################################

Polymorphism
Polymorphism refers to the ability of different object types to respond to the
same method invocation, often, but not always, in different ways. In other words,
data of different types can respond to a common interface. It's a crucial concept 
in OO programming that can lead to more maintainable code.

Encapsulation
Encapsulation lets us hide the internal representation of an object from the outside 
and only expose the methods and properties that users of the object need. We can use 
method access control to expose these properties and methods through the public (or external)
interface of a class: its public methods.

##############################################################################
################### Lecture: Collaborator Objects ############################
##############################################################################

Objects that are stored as state within another object are also called "collaborator objects".
We call such objects collaborators because they work in conjunction (or in collaboration) with
the class they are associated with. For instance, bob has a collaborator object stored in the
@pet variable. When we need that Bulldog object to perform some action (i.e. we want to 
access some behavior of @pet), then we can go through bob and call the method on the object
stored in @pet, such as speak or fetch.

##############################################################################
################### Lecture: Modules #########################################
##############################################################################

Ruby is a single inheritance language, meaning a class can only sub-class from one super class.

This can sometimes cause limitations when we want a sub class to adopt some but not all of the super classes
behaviours, and need to share that behavior amongst mutliple sub classes. The solution is to mixin modules
and include that module in appropriate classes.

We can mixin as many modules as we'd like, but it does affect the method look up path.

##############################################################################
################### Assignment: OO Rock Paper Scissors #######################
##############################################################################

# OO_RPS.rb



=end