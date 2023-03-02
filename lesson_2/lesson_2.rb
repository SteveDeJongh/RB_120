#### RB 120 Lesson 2 #####

=begin
# Lecture: Classes and Ojects
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

=end

