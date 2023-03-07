################################## RB 120 Lesson 3 ########################################

# Practice Problems: Easy 1

# Question 1)

# Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

# true
# "hello"
# [1, 2, 3, "happy days"]
# 142

# They are all objects.
# To see what class they belong to, we can call #.class

# Question 2)

# If we have a Car class and a Truck class and we want to be able to go_fast, 
# how can we add the ability for them to go_fast using the module Speed? How can
#  you check if your Car or Truck can now go fast?

# module Speed
#   def go_fast
#     puts "I am a #{self.class} and going super fast!"
#   end
# end

# class Car
#   include Speed # Required for Car to `go_fast`
#   def go_slow
#     puts "I am safe and driving slow."
#   end
# end

# class Truck
#   include Speed # Required for Truck to `go_fast`
#   def go_very_slow
#     puts "I am a heavy truck and like going very slow."
#   end
# end

# # To check:

# new_car = Car.new
# new_truck = Truck.new
# new_car.go_fast #=> "I am a Car and going super fast!"
# new_truck.go_fast #=> "I am a Truck and going super fast!"

# Question 3)

# In the last question we had a module called Speed which contained a go_fast method.
# We included this module in the Car class as shown below.

# When we called the go_fast method from an instance of the Car class (as shown below) 
# you might have noticed that the string printed when we go fast includes the name of the
#  type of vehicle we are using. How is this done?

# >> small_car = Car.new
# >> small_car.go_fast
# I am a Car and going super fast!

# The returned string from `go_fast` uses string interpolation and a call to `self.class` to
# return the objects class to the string.

# `self` in the case, refers to the `small_car` object
# We ask `self` to tell us it's class using `.class`
# We don't need a `to_s` as it's inside of a string.

# Question 4)
# If we have a class AngryCat how do we create a new instance of this class?

# The AngryCat class might look something like this:

# class AngryCat
#   def hiss
#     puts "Hisssss!!!"
#   end
# end

# new_cat = AngryCat.new

# Question 5)
# Which of these two classes would create objects that would have an instance
# variable and how do you know?

# class Fruit
#   def initialize(name)
#     name = name
#   end
# end

# class Pizza
#   def initialize(name)
#     @name = name
#   end
# end

# # Pizza would create objects that would have an instance variable.

# # To check that Fruit doesn't have any instance variables, we can create an object and 
# # call `instance_variables` on it to make sure

# hot_pizza = Pizza.new("cheese")
# orange    = Fruit.new("apple")

# p hot_pizza.instance_variables #=> [:@name]
# p orange.instance_variables #=> []

# Queston 6)
# What is the default return value of to_s when invoked on an object? 

# By default, to_s will return a name of the object's class and an encoding object_id

# Where could you go to find out if you want to be sure?
# https://ruby-doc.org/2.7.7/Object.html#method-i-to_s

# Question 7)

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

# You can see in the make_one_year_older method we have used self. What does self refer to here?

# `self` refers to the object instance of `Cat`. As `make_one_year_older` is an instance method
# it can only be called on instances of the class `Cat`. Keeping this in mind, `self` is referencing the 
# instance (object) that called the method - the calling object.

# Queston 8)

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

# In the name of the cats_count method we have used self. What does self refer to in this context?

# In this contect, the `self` defines a class method.

# Question 9)

# If we have the class below, what would you need to call to create a new instance of this class.

# class Bag
#   def initialize(color, material)
#     @color = color
#     @material = material
#   end
# end

# Bag.new('blue', 'cloth')
# To instantiate a new `bag` object, we need to call `new`, and as the initialize instance method
# is defined with two arguments, those need to be passed in as well.