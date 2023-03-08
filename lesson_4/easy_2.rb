################################## RB 120 Lesson 4 ########################################

# Practice Problems: Easy 2

# Question 1)

# class Oracle
#   def predict_the_future
#     "You will " + choices.sample
#   end

#   def choices
#     ["eat a nice lunch", "take a nap soon", "stay at work late"]
#   end
# end

# # What is the result of executing the following code?

# oracle = Oracle.new
# oracle.predict_the_future

# For every `predict_the_future` call, "You will (one of the choices" will be returned.

# Question 2)

# class Oracle
#   def predict_the_future
#     "You will " + choices.sample
#   end

#   def choices
#     ["eat a nice lunch", "take a nap soon", "stay at work late"]
#   end
# end

# class RoadTrip < Oracle
#   def choices
#     ["visit Vegas", "fly to Fiji", "romp in Rome"]
#   end
# end

# trip = RoadTrip.new
# trip.predict_the_future # will return "You will (any any of the choices from the Roadtrip class"

# This occurs as were calling `predict_the_future` on an instance of `roadtrip`, everytime Ruby
# tries to resolve a method name, it will start with the methods defined on the class
# you are calling. So even though the `choices` call happens in a method defined in `oracle`,
# Ruby will first look for a definition of `choices` in `Roadtrip`.

# Question 3)

# How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?

# module Taste
#   def flavor(flavor)
#     puts "#{flavor}"
#   end
# end

# class Orange
#   include Taste
# end

# class HotSauce
#   include Taste
# end

# What is the lookup chain for Orange and HotSauce?

# Orange < Taste < Object < Kernel, BasicObject
# HotSauce < Taste < object ...

# You can call #ancestors on a class of an object to check the method lookup chain.

# Question 4)

# What could you add to this class to simplify it and remove two methods from the class definition
# while still maintaining the same functionality?

# class BeesWax
#   #attr_accessor :type # Add to remove the type and type= method defs.

#   def initialize(type)
#     @type = type
#   end

#   def type
#     @type
#   end

#   def type=(t)
#     @type = t
#   end

#   def describe_type
#     puts "I am a #{@type} of Bees Wax" # We can also change @type to `type` to use the getter :type method.
#   end
# end

# Could add `attr_accessor :type` to remove both the type and type= method definitions.

# Question 5)

#There are a number of variables listed below. What are the different types and how do you know which is which?

# excited_dog = "excited dog" # local variable
# @excited_dog = "excited dog" # Instance variable
# @@excited_dog = "excited dog" # Class variable

# Question 6)

# If i have the following class:

# class Television
#   def self.manufacturer
#     # method logic
#   end

#   def model
#     # method logic
#   end
# end

# Which one of these is a class method (if any) and how do you know? How would you call a class method?

# `self.manufacturer` is a class method. We know it's a class method due to the method being prepended by `self`.

# To call a class method, `Television.manufacturer`, we use the class name and then calling method.

# Question 7)

# If we have a class such as the one below:

# class Cat
#   @@cats_count = 0

#   def initialize(type)
#     @type = type
#     @age  = 0
#     @@cats_count += 1
#   end

#   def self.cats_count
#     @@cats_count
#   end
# end

# Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?

# The @@cats_count variable tracks how many intances of the `Cat` object have been created. We can view this by using the
# class method `self.cats_count`.

# To check if this works:
# cat1 = Cat.new('breed')
# p Cat.cats_count #=> 1 # We could also call `puts` on @@cats_count from within the initilaize method.

# Question 8)

# If we have this class:
# class Game
#   def play
#     "Start the game!"
#   end
# end
# #And another class:
# class Bingo # Add `< Game` to inherit from the `Game` class.
#   def rules_of_play
#     #rules of play
#   end
# end
# What can we add to the Bingo class to allow it to inherit the play method from the Game class?

# `< Game`

# Question 9)

# If you have this class:
# class Game
#   def play
#     "Start the game!"
#   end
# end

# class Bingo < Game
#   def rules_of_play
#     #rules of play
#   end
# end

# What would happen if we added a play method to the Bingo class, keeping in mind that there is already a 
# method of this name in the Game class that the Bingo class inherits from.

# If a `play` method was added to the `Bingo` Class, that method would override the `Game` `play` method and be used
# instead when called on objects of `Bingo`. As soon as Ruby finds a method, it will stop looking up the chain.

# Question 10)

# What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.

# Because there are so many benefits to using OOP we will just summarize some of the major ones:

# 1) Creating objects allows programmers to think more abstractly about the code they are writing.
# 2) Objects are represented by nouns so are easier to conceptualize.
# 3) It allows us to only expose functionality to the parts of code that need it, meaning namespace issues are much
#    harder to come across.
# 4) It allows us to easily give functionality to different parts of an application without duplication.
# 5) We can build applications faster as we can reuse pre-written code.
# 6) As the software becomes more complex this complexity can be more easily managed.