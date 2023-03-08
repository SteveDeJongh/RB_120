################################## RB 120 Lesson 4 ########################################

# Practice Problems: Easy 3

# Question 1)
# If we have this code:

# class Greeting
#   def greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# What happens in each of the following cases:
# 1)
# hello = Hello.new
# hello.hi #=> "Hello"

# 2)
# hello = Hello.new
# hello.bye #=> Undefined method error, Hello object does not inherit the `bye` method from `Goodbye` class.

# 3)
# hello = Hello.new
# hello.greet #=> Argument error, Call to `greet` method in `greeting` class. Requires an argument.
# the Hello class can access teh method, but it requires a passed in argument.

# 4)
# hello = Hello.new
# hello.greet("Goodbye") #=> "Goodbye"

# 5)
# Hello.hi # No method error.
# `hi` method is defined as an instance method rather than  a class method.

# Question 2)

# class Greeting
#   def greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end

#   def self.hi # add this method definition.
#     greeting = Greeting.new
#     greeting.greet('Hello')
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# # If we call Hello.hi we get an error message. How would you fix this?

# Hello.hi

# Questions 3)

# When objects are created they are a separate realization of a particular class.
# Given the class below, how do we create two different instances of this class with separate names and ages?

# class AngryCat
#   def initialize(age, name)
#     @age  = age
#     @name = name
#   end

#   def age
#     puts @age
#   end

#   def name
#     puts @name
#   end

#   def hiss
#     puts "Hisssss!!!"
#   end
# end

# cat1 = AngryCat.new(12,'cattter')
# cat2 = AngryCat.new(13,'catterrini')

# Question 4)

# Given the class below, if we created a new instance of the class and then called to_s on that
# instance we would get something like "#<Cat:0x007ff39b356d30>"

# class Cat
#   attr_reader :type # getter method to access type in `to_s`

#   def initialize(type)
#     @type = type
#   end

#   def to_s
#     "I am a #{type} cat"
#   end
# end

# How could we go about changing the to_s output on this method to look like this: I am a tabby cat?
#  (this is assuming that "tabby" is the type we passed in during initialization).
# tabby = Cat.new('Tabby')
# puts tabby

# Question 5)

# If I have the following class:

# class Television
#   def self.manufacturer
#     # method logic
#   end

#   def model
#     # method logic
#   end
# end

# What would happen if I called the methods like shown below?

# tv = Television.new
# tv.manufacturer #=> Nomethoderror. `self.manufacturer` is a class method and `tv` is an instance of the television class.
# tv.model #=> works.

# Television.manufacturer #=> works
# Television.model #=> `model` is an instance method.

# Question 6)

# If we have a class such as the one below:

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

# In the make_one_year_older method we have used self. What is another way we could write
#  this method so we don't have to use the self prefix?

# self in this case is referencing the setter method provided by attr_accessor - this means that we could replace self 
# with @. So the revised method would look something like this:

# class Cat
#   attr_accessor :type, :age

#   def initialize(type)
#     @type = type
#     @age  = 0
#   end

#   def make_one_year_older
#     @age += 1
#   end
# end

# In this case, self and @ achieve the same thing and can be used interchangeably.

# Question 7)

# What is used in this class but doesn't add any value?

# class Light
#   attr_accessor :brightness, :color

#   def initialize(brightness, color)
#     @brightness = brightness
#     @color = color
#   end

#   def self.information
#     return "I want to turn on the light with a brightness level of super high and a color of green"
#   end

# end

# The `return` in the `self.information` method.