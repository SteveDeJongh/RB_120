########## RB 129 Practice Problems #######
require 'pry'
# 1.
# class Person
#   attr_reader :name
  
#   def set_name
#     @name = 'Bob'
#   end
# end

# bob = Person.new
# bob.set_name # Add this to initialize @name and make the code output "Bob"
# p bob.name

# What is output and why? What does this demonstrate about instance variables that differentiates them from local variables?

# This code outputs `nil`. This is due to the fact that the instance variable `@name` has not been initalized, as the `set_name` instance
# method has yet to be invoked. The demonstrates the difference of instnace variables against local variables, as uninitiailzied
# local variables would raise an error.

# 2.
# module Swimmable
#   def enable_swimming
#     @can_swim = true
#   end
# end

# class Dog
#   include Swimmable

#   def swim
#     "swimming!" if @can_swim
#   end
# end

# teddy = Dog.new
# teddy.enable_swimming # Add this so that @can_swim is true, and output will be `swimming!`
# p teddy.swim   

# What is output and why? What does this demonstrate about instance variables?

# The code outputs nil. This is due to the instance variable @can_swim having not been initialized yet.
# This example also demonstrates that objects can inherit instance variables from modules.
# To solve the issue and get the output `swimming!`, we must first invoke the `enable_swimming` method.

# 3. 
# module Describable
#   def describe_shape
#     "I am a #{self.class} and have #{self.class::SIDES} sides." # Self refers to the calling object. `self.class::` added to make code run.
#   end
# end

# class Shape
#   include Describable

#   def self.sides # Self refers to the Shape class.
#     self::SIDES # refers to `Shape` class, would not have access to SIDES constant in Quadrilateral.
#   end
  
#   def sides
#     self.class::SIDES # Self refers to the calling object.
#   end
# end

# class Quadrilateral < Shape
#   SIDES = 4
# end

# class Square < Quadrilateral; end

# p Square.sides #=> 4
# p Square.new.sides #=> 4
# p Square.new.describe_shape #=> Raises a unitialized constant error. Need to add `self.class::SIDES` in describable module.

# What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above?

# This example demonstrates constants lexical scope. In order for the describe_shape method defined in the `describable` module to have access
# to the SIDES constant defined in `Quadrilateral`, we can solve this by using the namespace resolution operator with self.class.

# 4.
# class AnimalClass
#   attr_accessor :name, :animals
  
#   def initialize(name)
#     @name = name
#     @animals = []
#   end
  
#   def <<(animal)
#     animals << animal
#   end
  
#   # def +(other_class)
#   #   animals + other_class.animals
#   # end

#   def +(other_class)
#     temp_class = AnimalClass.new('temp_name')
#     temp_class.animals = animals + other_class.animals
#     temp_class
#   end
# end

# class Animal
#   attr_reader :name
  
#   def initialize(name)
#     @name = name
#   end
# end

# mammals = AnimalClass.new('Mammals')
# mammals << Animal.new('Human')
# mammals << Animal.new('Dog')
# mammals << Animal.new('Cat')

# birds = AnimalClass.new('Birds')
# birds << Animal.new('Eagle')
# birds << Animal.new('Blue Jay')
# birds << Animal.new('Penguin')

# some_animal_classes = mammals + birds

# p some_animal_classes #=> returns an array of all animals from both mammals and birds

# What is output? Is this what we would expect when using `AnimalClass#+`? If not, how could we adjust the implementation of `AnimalClass#+` to be more in line with what we'd expect the method to return?

# If we wanted to instead return a new AnimalClass object, the implementaiton of `Animalclass#+` should be:

# def +(other_class)
#   temp_class = AnimalClass.new('temp_name')
#   temp_class.animals = animals + other_class.animals
#   temp_class
# end

# 5.
# class GoodDog
#   attr_accessor :name, :height, :weight

#   def initialize(n, h, w)
#     @name = n
#     @height = h
#     @weight = w
#   end

#   def change_info(n, h, w)
#     self.name = n # prepend self. instead of just `name`
#     self.height = h # prepend self. instead of just `name`
#     self.weight = w # prepend self. instead of just `name`
#   end

#   def info
#     "#{name} weighs #{weight} and is #{height} tall."
#   end
# end

# sparky = GoodDog.new('Spartacus', '12 inches', '10 lbs') 
# sparky.change_info('Spartacus', '24 inches', '45 lbs')
# puts sparky.info 
# => Spartacus weighs 10 lbs and is 12 inches tall.

# We expect the code above to output `”Spartacus weighs 45 lbs and is 24 inches tall.”` Why does our `change_info` method not work as expected?

# The current implementation of `change_info` is actually initiailizing new local variables for `name`, `height`, and `weight`.
# In order for `change_info` to work as intended, we would need to prepend `self` to each variable to that it insteads references
# each of the calling objects instance variables.

# 6.
# class Person
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
  
#   def change_name
#     self.name = name.upcase # prepend name with `self.`
#   end
# end

# bob = Person.new('Bob')
# p bob.name 
# bob.change_name
# p bob.name

# In the code above, we hope to output `'BOB'` on `line 16`. Instead, we raise an error. Why? How could we adjust this code to output `'BOB'`? 

# This is another example of initializing a local variable rather than modifying the objects instance variable. Here, we need to again
# prepend `self` to the instance variable to referencing the calling objects instance variable setter method.

# 7.
# class Vehicle
#   @@wheels = 4

#   def self.wheels
#     @@wheels
#   end
# end

# p Vehicle.wheels                             #=> 4

# class Motorcycle < Vehicle
#   @@wheels = 2
# end

# p Motorcycle.wheels                           #=> 2
# p Vehicle.wheels                              #=> 2

# class Car < Vehicle; end

# p Vehicle.wheels #=> 2
# p Motorcycle.wheels #=> 2   
# p Car.wheels     #=> 2

# What does the code above output, and why? What does this demonstrate about class variables, and why we should avoid
# using class variables when working with inheritance?

# This highlights the fact that when using inheritance, 1 copy of the class variable is shared by all 
# subclass that inherit the class variable from their superclass.

# 8.
# class Animal
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
# end

# class GoodDog < Animal
#   def initialize(color)
#     super
#     @color = color
#   end
# end

# bruno = GoodDog.new("brown")       
# p bruno #=> <GoodDog:encoding of object id, @name = 'brown, @color = 'brown'>

# What is output and why? What does this demonstrate about `super`?

# The output shows that both the `Animal` instance variable name and the GoodDog instance variable `color` are assigned the passed in
# value of `brown` upon instantiation of the `bruno` GoodDog object.

# This is because by default, `super` passes all arguments up the method lookup chain. If we wanted to avoid this, we could append
# super with `()`

# 9.
# class Animal
#   def initialize
#   end
# end

# class Bear < Animal
#   def initialize(color)
#     super
#     @color = color
#   end
# end

# bear = Bear.new("black")        

# What is output and why? What does this demonstrate about `super`? 

# This code raises an error, as `super` passes the `color` argument up the method lookup path to `Animal`s `initialize` method which
# does not accept any arguments. This demonstrates that by default, `super` passes every argument up the chain. To fix this, we
# could append `super` with () to ensure no arguments are passed.

# 10.
# module Walkable
#   def walk
#     "I'm walking."
#   end
# end

# module Swimmable
#   def swim
#     "I'm swimming."
#   end
# end

# module Climbable
#   def climb
#     "I'm climbing."
#   end
# end

# module Danceable
#   def dance
#     "I'm dancing."
#   end
# end

# class Animal
#   include Walkable

#   def speak
#     "I'm an animal, and I speak!"
#   end
# end

# module GoodAnimals
#   include Climbable

#   class GoodDog < Animal
#     include Swimmable
#     include Danceable
#   end
  
#   class GoodCat < Animal; end
# end

# good_dog = GoodAnimals::GoodDog.new
# p good_dog.walk

# What is the method lookup path used when invoking `#walk` on `good_dog`?

# GoodAnimals::GoodDog -> Danceable -> Swimmable -> Animal -> Walkable (found `walk`!)

# 11.
# class Animal
#   def eat
#     puts "I eat."
#   end
# end

# class Fish < Animal
#   def eat
#     puts "I eat plankton."
#   end
# end

# class Dog < Animal
#   def eat
#      puts "I eat kibble."
#   end
# end

# def feed_animal(animal)
#   animal.eat
# end

# array_of_animals = [Animal.new, Fish.new, Dog.new]
# array_of_animals.each do |animal|
#   feed_animal(animal)
# end

# What is output and why? How does this code demonstrate polymorphism?

# output:
# "I eat."
# "I eat plankton."
# "I eat kibble."

# This code demonstrates polymorphism through inheritance.
# In this example, the client code doesn't care what each object is, just that they each have an available `eat` method.
# This example shows polymorphism in which different object types can respond to the same method call by overriding a method inherited
# from a superclass.

# 12.
# class Person
#   attr_accessor :name, :pets

#   def initialize(name)
#     @name = name
#     @pets = []
#   end
# end

# class Pet
#   def jump
#     puts "I'm jumping!"
#   end
# end

# class Cat < Pet; end

# class Bulldog < Pet; end

# bob = Person.new("Robert")

# kitty = Cat.new
# bud = Bulldog.new

# bob.pets << kitty
# bob.pets << bud                     

# bob.pets.jump 

# We raise an error in the code above. Why? What do `kitty` and `bud` represent in relation to our `Person` object?  

# A undefined method error is raised as we are calling `jump` on the `pets` array itself, rather than the pet objects within.

# Kitty and Bud represent collaborator objects to the Person object, as they are stored as state in the `Person` object's
# instance variable `pets`

# In order to get the desired output, we would need to call `jump` on each objects within the pets array.

# bob.pets.each {|x| x.jump}

# 13.
# class Animal
#   def initialize(name)
#     @name = name
#   end
# end

# class Dog < Animal
#   def initialize(name)
#     super # Or @name = name, either option fixes the problem.
#   end

#   def dog_name
#     "bark! bark! #{@name} bark! bark!"
#   end
# end

# teddy = Dog.new("Teddy")
# puts teddy.dog_name   

# What is output and why?

# Output: 'bark! bark!  bark! bark!'

# This is due to the `@name` instance variabel not being initialized, and therfor the reference to @name in `dog_name` referencing `nil`.
# We can fix this by either intitializing the `@name` instance variable within our dog#intialize method, or by passing in `super` to
# use the `Animal` class initialize method definition which initiailizes the instance variable.

# 14.
# class Person
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def ==(other)
#     self.name == other.name
#   end
# end

# al = Person.new('Alexander')
# alex = Person.new('Alexander')
# p al == alex # => true

# In the code above, we want to compare whether the two objects have the same name. `Line 11` currently returns `false`. How could we return `true` on `line 11`? 

# In order for `al == alex` to return true, we need to define a `==` method in the `Person` class. By default, the `==` compares each
# objects objectID, which would be different.

# def ==(other)
#   self.name == other.name
# end

# Further, since `al.name == alex.name` returns `true`, does this mean the `String` objects referenced by `al` and `alex`'s `@name` instance variables are the same object? How could we prove our case?

# The two string objects stored as instance variables are different objects. We could call object_id on the instance variables themselves.

# p al.name #=> "Alexander"
# p al.name.object_id #=> 60
# p alex.name #=> "Alexander"
# p alex.name.object_id #=> 80

# 15.
# class Person
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     "My name is #{name.upcase!}."
#   end
# end

# bob = Person.new('Bob')
# puts bob.name #=> 'Bob'
# puts bob #=> "My name is BOB." # We've overridden the to_s method, and used a mutating `upcase!` method call on the instance variable @name.
# puts bob.name #=> "BOB"

# What is output on `lines 14, 15, and 16` and why?

#  16.
# Why is it generally safer to invoke a setter method (if available) vs. referencing the instance variable directly when trying to
# set an instance variable within the class? Give an example.

# ?????????????????

# 17.
# Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`.

# It would make sense to write a custom getter method vs an attr_reader method when we want to control how the information is going to be
# displayed, or to control how much of the raw data is exposed.

# Supose we have a bank account number which we only want to display the last 4 digits everytime it's referened.

# We could write something like: 'xxxx-xxxx-' + @bankaccount.to_s.split('')[-4..-1].join everytime we wanted to display the bank number.

# If we instead have a custom getter method, we could simply call it.

# def bankaccount
#   'xxxx-xxxx-' + @bankaccount.to_s.split('')[-4..-1].join
# end

# This would allow us to make easy changes to how we want the information displayed throughout the program.

# 18. 
# class Shape
#   @@sides = nil

#   def self.sides
#     @@sides
#   end

#   def sides
#     @@sides
#   end
# end

# class Triangle < Shape
#   def initialize
#     @@sides = 3
#   end
# end

# class Quadrilateral < Shape
#   def initialize
#     @@sides = 4
#   end
# end

# What can executing `Triangle.sides` return? What can executing `Triangle.new.sides` return? What does this demonstrate about class variables?

# p Triangle.sides #=> `nil`
# p Triangle.new.sides #=> 3
# p Quadrilateral.sides #=> 3
# p Quadrilateral.new.sides #=> 4

# This code example demonstrates why we should avoid using class variables in the context of inheritance. As there exists only 1 copy of the
# class variable, any changes to it down the line will affect the single copy.

# Once a Triangle, or Quadrilateral object is instantiated, the `@@sides` class variable will be changed to either 3 or 4.

# 19.
# What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor` methods for every instance variable in our class? Give an example.

# The `attr_accesssor` method is the method that creates getter and setter method for the instance variables listed after as symbols.
# We maybe not want to add attr_accessor methods for every instance variable as we may have some instance variables that we don't want to change.

# For example:

# class Account
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#     @date_created = Time.new
#   end
# end

# ron = Account.new('steve')
# p ron
# p ron.name
# # ron.date_created = "now!?" # Raises an error as we don't have accessor methods for @date_created

# 20.
# What is the difference between states and behaviors?

# The difference between state and behaviors is that state is tracked at the object level via instance variables unique to each object,
# while behaviors are instance methods available to all instances of the class.

# 21. 
# What is the difference between instance methods and class methods?

# Instance methods are methods which are accessible to objects of that class. Class methods are only able to be called on the class itself,
# often exposing data about the class. We do not need to instantiate any objects of the class to call a class method.

# 22.
# What are collaborator objects, and what is the purpose of using them in OOP? Give an example of how we would work with one.

# Collaborator objects are objects which are stored as state in a seperate object.

# An example of this would be a human and their pets.

# class Human
#   attr_reader :pets

#   def initialize(name)
#     @name = name
#     @pets = []
#   end

#   def add_pet(x)
#     self.pets << x
#   end
# end

# class Pet
#   def initialize(name, type)
#     @name = name
#     @type = type
#   end
# end

# steve = Human.new('Steve')
# p steve.pets #=> empty array
# gryff = Pet.new('Gryff', 'Dog')
# steve.add_pet(gryff)
# p steve.pets #=> [<pet:encoding, @name = 'Gryff', @type = 'Dog'>]

# 23.
# How and why would we implement a fake operator in a custom class? Give an example.

# class Human
#   def initialize(name)
#     @name = name
#     @pets = []
#   end

#   def <<(thing)
#     @pets << thing
#   end
# end

# steve = Human.new('steve')
# steve << 'gryff'
# p steve

# 24.
# What are the use cases for `self` in Ruby, and how does `self` change based on the scope it is used in? Provide examples.

# `self` can be used in a few different ways. `self` before a method name in a class definition indicates the method is a class method.
# Otherwise, if `self` is used inside of a method definition, it references the instance that called the method, the calling object.

# class Human
#   attr_accessor :name

#   def self.what_am_i? # Class method
#     self #=> "Human"
#   end

#   def change_name(name)
#     self.name = name # calls the `name` writer method
#   end
# end

# p Human.what_am_i?

# 25.
# class Person
#   def initialize(n)
#     @name = n
#   end
  
#   def get_name
#     @name
#   end
# end

# bob = Person.new('bob')
# joe = Person.new('joe')

# puts bob.inspect # => #<Person:0x000055e79be5dea8 @name="bob">
# puts joe.inspect # => #<Person:0x000055e79be5de58 @name="joe">

# p bob.get_name # => "bob"

# What does the above code demonstrate about how instance variables are scoped?

# The above code demonstrates that instance variables are scoped at the object level. Instance variables are accessible to instance methods
# even if defined outside of the method and not passed in as an argument.

# 26.
# How do class inheritance and mixing in modules affect instance variable scope? Give an example.

# Superclass instance variables are accessible providing they are initialized. ex:

# class Parent
#   def initialize(name)
#     @name = name
#   end

# end

# class Kid < Parent
#   def name
#     puts "#{@name}"
#   end
# end

# ted = Kid.new('ted')
# ted.name # 'ted' # using the Parent instance variable @name

# # When mixing in modules, as long as the method is called before trying to access the instance variable, the code will behave as expected.

# module Swimmable
#   def good_to_swim
#     @can_swim = true
#   end
# end

# class Dog
#   include Swimmable

#   def swim
#     "Swimming!" if @can_swim
#   end
# end

# ted = Dog.new
# p ted.swim # nil
# ted.good_to_swim # method call required to initialize @can_swim instance variable.
# p ted.swim #=> Swimming!

# 27.
# How does encapsulation relate to the public interface of a class?

# Encapsulation lets us hide the internal representation of an object from the outside and only expose the methods and properties
# that users of the object need. We used method access control to expose these properties and methods through the public interface of a class.

# 28.
# class GoodDog
#   DOG_YEARS = 7

#   attr_accessor :name, :age

#   def initialize(n, a)
#     self.name = n
#     self.age  = a * DOG_YEARS
#   end
# end

# sparky = GoodDog.new("Sparky", 4)
# puts sparky #=> <Gooddog:encoding of object id>

# What is output and why? How could we output a message of our choice instead?

# This is because we are using the default implementation of `to_s`, which does not call `inspect`.
# If we wanted the code above to output a message of our choice, we could define our own `to_s` method to override the default implementation.

# How is the output above different than the output of the code below, and why?

# class GoodDog
#   DOG_YEARS = 7

#   attr_accessor :name, :age

#   def initialize(n, a)
#     @name = n
#     @age  = a * DOG_YEARS
#   end
# end

# sparky = GoodDog.new("Sparky", 4)
# p sparky #=> <GoodDog:encoding of object ID @age = 28, @name = 'Sparky'>

# This is because we are now calling the `p` method, wich instead of caling `to_s` calls `inspect` instead.

# 29.
# When does accidental method overriding occur, and why? Give an example.

# accidental method overriding occurs when we name our class defined method the same as an inherited method we were not meaning to overrride.
# This often occurs with methods defined in the `object` class, as all classes inherit from it. A commonly overrriden method is `to_s`,
# while the `send` method (among others) can be accidentaly overrriden.

# 30.
# How is Method Access Control implemented in Ruby? Provide examples of when we would use public, protected, and private access modifiers.

# Method access control is impltemented using the access modifiers `public`, `private`, and `protected` keywords.

# Public is the default access level for mehods defined in a class. The method is available to anyone who knows either the class name or
# objects name. The methods are available for the rest of the program to use and comprise the class's interface.

# Private methods are methods which can only be called from within the class definiton. Anything defined below the `private` method call
# in a class private unless another access modifier method is called. We could use private methods when we want to hide functionality
# of certain methods, and only have them implemented in certain ways using other public methods.

# Protected methods are an inbetween approach in that they cannot be invoked outside of the class, but are available for use between instances
# of the class. This is most commonly used by comparison operators when gaining access to the variable we wish to compare.

# 31.
# Describe the distinction between modules and classes.

# Modules can be thought of as containers of behaviors. They differ from classes as they can not instantiate any objects. Modules
# typically share a 'has_a' relationship to the classes which they are included in. 

# Classes are molds for the bahviors and states of instantiated objects. They contain the methods and behaviors the objects can do,
# along with outlining the instance variables used to track each unique objects state. Classes have a "is_a" relationship with the objects
# which are created from the class. Classes can only subclass from 1 superclass, however they can mixin in as many modules as they'd like.

# 32.
# What is polymorphism and how can we implement polymorphism in Ruby? Provide examples.



# 33.
# # What is encapsulation, and why is it important in Ruby? Give an example.
# 34.
# module Walkable
#   def walk
#     "#{name} #{gait} forward"
#   end
# end

# class Person
#   include Walkable

#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   private

#   def gait
#     "strolls"
#   end
# end

# class Cat
#   include Walkable

#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   private

#   def gait
#     "saunters"
#   end
# end

# mike = Person.new("Mike")
# p mike.walk

# kitty = Cat.new("Kitty")
# p kitty.walk


# # What is returned/output in the code? Why did it make more sense to use a module as a mixin vs. defining a parent class and using class inheritance?
# 35.
# # What is Object Oriented Programming, and why was it created? What are the benefits of OOP, and examples of problems it solves?

# 36.
# # What is the relationship between classes and objects in Ruby?
# 37.
# # When should we use class inheritance vs. interface inheritance?
# 38.
# class Cat
# end

# whiskers = Cat.new
# ginger = Cat.new
# paws = Cat.new


# # If we use `==` to compare the individual `Cat` objects in the code above, will the return value be `true`? Why or why not? What does this demonstrate about classes and objects in Ruby, as well as the `==` method?
# 39.
# class Thing
# end

# class AnotherThing < Thing
# end

# class SomethingElse < AnotherThing
# end


# # Describe the inheritance structure in the code above, and identify all the superclasses.
# 40.
# module Flight
#   def fly; end
# end

# module Aquatic
#   def swim; end
# end

# module Migratory
#   def migrate; end
# end

# class Animal
# end

# class Bird < Animal
# end

# class Penguin < Bird
#   include Aquatic
#   include Migratory
# end

# pingu = Penguin.new
# pingu.fly


# What is the method lookup path that Ruby will use as a result of the call to the `fly` method? Explain how we can verify this.
# 41.
# class Animal
#   def initialize(name)
#     @name = name
#   end

#   def speak
#     puts sound
#   end

#   def sound
#     "#{@name} says "
#   end
# end

# class Cow < Animal
#   def sound
#     super + "moooooooooooo!"
#   end
# end

# daisy = Cow.new("Daisy")
# daisy.speak


# # What does this code output and why?

# 42.
# class Cat
#   def initialize(name, coloring)
#     @name = name
#     @coloring = coloring
#   end

#   def purr; end

#   def jump; end

#   def sleep; end

#   def eat; end
# end

# max = Cat.new("Max", "tabby")
# molly = Cat.new("Molly", "gray")


# # Do `molly` and `max` have the same states and behaviors in the code above? Explain why or why not, and what this demonstrates about objects in Ruby.

# 43.
# class Student
#   attr_accessor :name, :grade

#   def initialize(name)
#     @name = name
#     @grade = nil
#   end
  
#   def change_grade(new_grade)
#     grade = new_grade
#   end
# end

# priya = Student.new("Priya")
# priya.change_grade('A')
# priya.grade 


# # In the above code snippet, we want to return `”A”`. What is actually returned and why? How could we adjust the code to produce the desired result?
# 44.
# class MeMyselfAndI
#   self

#   def self.me
#     self
#   end

#   def myself
#     self
#   end
# end

# i = MeMyselfAndI.new


# # What does each `self` refer to in the above code snippet?

# 45.
# class Student
#   attr_accessor :grade

#   def initialize(name, grade=nil)
#     @name = name
#   end 
# end

# ade = Student.new('Adewale')
# p ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">


# # Running the following code will not produce the output shown on the last line. Why not? What would we need to change, and what does this demonstrate about instance variables?
# 46.
# class Character
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end

#   def speak
#     "#{@name} is speaking."
#   end
# end

# class Knight < Character
#   def name
#     "Sir " + super
#   end
# end

# sir_gallant = Knight.new("Gallant")
# p sir_gallant.name 
# p sir_gallant.speak 


# # What is output and returned, and why? What would we need to change so that the last line outputs `”Sir Gallant is speaking.”`? 

# 47. 
# class FarmAnimal
#   def speak
#     "#{self} says "
#   end
# end

# class Sheep < FarmAnimal
#   def speak
#     super + "baa!"
#   end
# end

# class Lamb < Sheep
#   def speak
#     super + "baaaaaaa!"
#   end
# end

# class Cow < FarmAnimal
#   def speak
#     super + "mooooooo!"
#   end
# end

# p Sheep.new.speak
# p Lamb.new.speak
# p Cow.new.speak 


# # What is output and why? 
# 48.
# class Person
#   def initialize(name)
#     @name = name
#   end
# end

# class Cat
#   def initialize(name, owner)
#     @name = name
#     @owner = owner
#   end
# end

# sara = Person.new("Sara")
# fluffy = Cat.new("Fluffy", sara)


# # What are the collaborator objects in the above code snippet, and what makes them collaborator objects?
# 49.
# number = 42

# case number
# when 1          then 'first'
# when 10, 20, 30 then 'second'
# when 40..49     then 'third'
# end


# # What methods does this `case` statement use to determine which `when` clause is executed?

# 50.
# class Person
#   TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

#   @@total_people = 0

#   def initialize(name)
#     @name = name
#   end

#   def age
#     @age
#   end
# end

# # What are the scopes of each of the different variables in the above code?
# 51.
# # The following is a short description of an application that lets a customer place an order for a meal:

# # - A meal always has three meal items: a burger, a side, and drink.
# # - For each meal item, the customer must choose an option.
# # - The application must compute the total cost of the order.

# # 1. Identify the nouns and verbs we need in order to model our classes and methods.
# # 2. Create an outline in code (a spike) of the structure of this application.
# # 3. Place methods in the appropriate classes to correspond with various verbs.

# 52. 
# class Cat
#   attr_accessor :type, :age

#   def initialize(type)
#     @type = type
#     @age  = 0
#   end

#   def make_one_year_older
#     self.age += 1
#   end
# end


# # In the `make_one_year_older` method we have used `self`. What is another way we could write this method so we don't have to use the `self` prefix? Which use case would be preferred according to best practices in Ruby, and why?
# 53.
# module Drivable
#   def self.drive
#   end
# end

# class Car
#   include Drivable
# end

# bobs_car = Car.new
# bobs_car.drive


# # What is output and why? What does this demonstrate about how methods need to be defined in modules, and why?
# 54.
# class House
#   attr_reader :price

#   def initialize(price)
#     @price = price
#   end
# end

# home1 = House.new(100_000)
# home2 = House.new(150_000)
# puts "Home 1 is cheaper" if home1 < home2 # => Home 1 is cheaper
# puts "Home 2 is more expensive" if home2 > home1 # => Home 2 is more expensive


# # What module/method could we add to the above code snippet to output the desired output on the last 2 lines, and why?
