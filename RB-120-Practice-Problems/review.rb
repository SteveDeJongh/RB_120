##### RB 120 OOP Review ####

# RB 129 Assesment Format
# Written:
# ~20 questions, 3 hours to complete.
# Interview:
# Explain concepts with precision while writing out code examples.

# Specific Topics of Interest
# Classes and objects
# Use attr_* to create setter and getter methods
# How to call setters and getters
# Instance variables, class variables, and constants, including the scope of each type and how inheritance can affect that scope
# Instance methods vs. class methods
# Method Access Control
# Referencing and setting instance variables vs. using getters and setters
# Class inheritance, encapsulation, and polymorphism
# Modules
# Method lookup path
# self
# Calling methods with self
# More about self
# Reading OO code
# Fake operators and equality
# Working with collaborator objects
# Create a code spike

# OOP LS 120 Questions

# March 17th RB 129 Study Session
=begin
RB 129 assessment FORMAT
Written:
3 Hour time limit

Interview:
Explaining concepts with code examples.

Notes:
Class objects relationships
Be able to produce code examples for concepts of OOP
Describe what concepts are at work.

The goal of the tests are to test our understanding of the concepts and our mental models.


# Example questions:
1)

class Dog
  def initialize(name)
    @name = name
  end
end

puppy = Dog.new('Benji')
another_puppy = Dog.new('Benji')

# What will this output? Why?

p puppy == another_puppy

# If we did run the code, what would be output on line 35 and why?

# On 35 we are checking the equality of two objects of the Dog class. The output is false, as the `==` method
# checks if the both objects are the same by object identity.

# In order to check equality via the instance variable names, we have to define a new `==` method inside the class.

attr_reader :name

def ==(other)
  name == other.name
end

# We would also have to create getter methods in order to access the name variable in the other object.

# 2)

# Tell us a little about `Method Access control` with a few examples.
# MAC is that excecise of using Public, private, and protected methods within a class's defintion.
# By default, all method defined in a class are public. The means that the method can be called anywhere in the codebase.
# Private methods can only be called from within the class and are hidden from calls from outside of the class definition.
# Protected methods are accessible to call from all instances of the same class.

# 3)

class Parent
  def hello(subject='World')
    puts "Hello, #{subject}"
  end
end

class Child < Parent
  def hello(subject)
    puts "How are you today?"
  end
end

child = Child.new
child.hello('Bob') #=> How are you today? # To call the Parent version, we can change the method names, or call super
# to call both hello methods.

# 4)

# class Cat
#   def initialize(name)
#     @name = name
#   end

#   def what_am_i?
#     self
#   end
# end

# fluffy = Cat.new('Fluffy')
# p fluffy.what_am_i? # what is output? #=> String represenation of the object with class name and any instance variables.

# class Cat
#   def initialize(name)
#     @name = name
#   end

#   def what_am_i?
#     self
#   end
# end

# class Persian < Cat; end

# fluffy = Persian.new('Fluffy')
# p fluffy.what_am_i? # what is output? #=> String represenation of the object with class name (this time persian) and any instance variables.

class Cat
  def initialize(name)
    @name = name
  end

  def what_am_i?
    self
  end

  def who_am_i?
    name # This is being called on `self`. 
  end

  def self.what_am_i?
    self
  end

  private

  attr_reader :name
end

class Persian < Cat; end

fluffy = Persian.new('Fluffy')
p fluffy.who_am_i? # Fluffy

p fluffy.what_am_i?.what_am_i? # Persian

=end


################################################################################################
###################################### LS 120 Questions ########################################
################################################################################################
=begin

1) What is OOP and why is it important?

OOP is an abreviation of Object Oritented programming. It's a programming paradigm that was created to deal
with the growing complexity of large software systems. The approach helps with maintenance, and avoids issues
where one small change an trigger a ripple effect of problems throughout the code.

OOP enables programmers to create containers for data that can be changed and manipulated without affecting the
rest of the program.

2) What is encapsulation?

Encalsulation is hiding pieces of functionality and making it unavailable to teh rest of the code base.
It's a form of data protection, and defines the boundaries of your application and allows your code to acheive
new levels of complexity. To accomplish this in ruby, you create objects and exposing interfaces (methods)
to interact with those objects.

Creating objects also enables the programmer to thing on a new level of abstraction with objects represented
as real world nouns and given methods that describe the behavior.

3) How does encapsulation relate to the public interface of a class?

4) What is an object?
An object is an instance of a class. The object are created from the mold of a class, and contain state.
Individual objects will contain different information from other objects, but are instances of the same class.

5) What is a class?

Classes can be thought of as molds of which objects are created from. Classes contain the defined behaviors and
attributes of it's objects.

6) What is instantiation?

Instantiation is the workflow of creating a new object of a class and storing it in a variable. This is done 
by using the `new` keyword on the classes name. ie : steve = Person.new

7) What is polymorphism?

Polymorphism is the ability of different types of data to respond to the same method invocation, often, in different
ways.

When two or more object types have a method with the same name, we can invoke that method with any of those objects.
When we don't care what type of object is calling the method, we're using polymorphism.

8) Explain two different ways to implement polymorphism.

Polymorphism can be implemented using inheritance (either class or interface(modules)) or duck typing.
An example of polymorphism using inheritance would be having a vehicle superclass with a `move` method, and subclasses `racecar`, `minivan`
also with `move` methods.

class Vehicle
  def move
    "We're moving!"
  end
end

class Racecar < Vehicle
  def move
    "Speeds away!"
  end
end

class Minivan < Vehicle; end

van = Minivan.new
rc = Racecar.new
p van.move #=> We're moving!
p rc.move #=> Speeds away!

It can also be accomplished via ducktyping, when objects of unrelated types respond to the same method invocation.

class Vehicle
  def move
    "Vehicle moving!"
  end
end

class Person
  def move
    "Person is moving!"
  end
end

van = Vehicle.new
person = Person.new

arr = [van, person]
arr.each {|x| puts x.move}

9) How does polymorphism work in relation to the public interface?

Polymorhpism allows the programmer to use all different types of objects in the same way, even though the implementations can be
dramatically different.

10) What is duck typing? How does it relate to polymorphism - what problem does it solve?

Duck typing is when object of different unrelated types both respond to the same method name. Duck typing allows polymorphism
in scenarios where there is no logical link between classes and mixin modules.

11) What is inheritance?

Inheritance can come in two form, class inheritance or interface inheritance. Class inheritances is when a class subclasses from
a supperclass and inherits all of it's behaviors. Interface inheritance is when a module is mixed in, and it's behavors can be used in
the class.

12) What is the difference between a superclass and a subclass?

A superclass is a class from with a subclass inherits behavior from. A subclass is a class which inherits behavior from a superclass.

13) what is a module?

A module is a collection of behaviors that are usable in other classes via mixins. A module is mixed in using the `include` method ivnocation.
A module can not instantiate an object.

14) What is a mixin?

A mixin in when a module has been included into a class.

15) When is it good to use inheritance?

Class based inheritance works great when it's used to model hierarchical domains. Inheritance is best used in a "is_a" relationship.
Ie: a dog is a animal, and the dog class could subclass from the animal superclass.

16) In inheritance, when would it be good to override a method?

A good time to overrride a method would be when the subclass object can not use the inherited method.

17) What is the method lookup path?

The method lookup path is the path ruby takes when searching for a method name.

18) When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts?

State refers to the data associated with an individual object represented as instance variables, and are unique to each object of that class.
Behaviors are methods available to all instances of that class.

19) How do you initialize a new object?

To instantiate a new object, you call `new` on the objects class, and pass to new any intiailzing arguments.

20) What is a constructor method?

The constructor method is the `initialize` method, a special method called whena new object is instnatiated.

21) What is an instance variable, and how is it related to an object?

Instance variables are variables tied to individual objects. They contain information regarding the objects state (ie: name, age, weight,etc..)
They are identified by starting with a single `@` symbol, and scoped at the object level.

22) What is an instance method?

Instance methods are methods available to all objects of that class. They are often referred to as behaviors of that class, and are actions
instances of that class can make.

23) How do objects encapsulate state?

Objects encapsulate state by the use of instance variables. Instance variables can contain anything, strings, arrays, intergers, other objects, etc.

24) What is the difference between classes and objects?

Classes are the defined mold of an object. They contain the instructions on data to retrive when instantiating a new object, and the behaviors
availalbe to that object.

Objects are created from classes, and contain individual states. Objects act on behaviors defined in the class.

25) How can we expose information about the state of the object using instance methods?

To expose information about an object, we use getter instnace methods. Getter methods retrieve and often output the information contained
in an objects instance variables.

26) What is a collaborator object, and what is the purpose of using collaborator objects in OOP?

A collaborator object is an object that is part of another objects state. The object can be any type of object.
Collaborator objects can often identify intended relationships between different objects in our code.

# Page 2

27) What is an accessor method?

An accessor method is a method created to either return or set the value of an objects instnace variable. Ruby convention states the method
name should be the same as the instance variable itself, adding a `=` for the setter method. Ruby's syntactical sugar allows for setter
methods to be called in very reader friendly manner, obj.name = "new_name" instead of obj.name=("new_name").

28) What is a getter method?

A getter method is a method written to retrieve and often output the value of an instnace variable.

29) What is a setter method?

A setter method is a method used to assign a value to an objects instance variable. Typically written as `varname=(newname)`, ruby's syntactical
sugar allows for the method to be called as so: obj.name = "Steve".

30) What is attr_accessor?

An accessor method is a method created using `attr_accessor` followed by a symbol of the instance variable. `attr_accessor` creates
getter and setter methods for the instance variable listed as symbol, and will also initialize the instance variable if not already
defined.

If we wanted to create just a getter method, we can use `attr_reader` or `attr_writer` for just a setter method.

31) How do you decide whether to reference an instance variable or a getter method?

  class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    name = n
    height = h
    weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info      
# => Sparky weighs 10 lbs and is 12 inches tall.

32) # Why does the .change_info method not work as expected here?


33) When would you call a method with self?
34) What are class methods?
35) What is the purpose of a class variable?
36) What is a constant variable?
37) What is the default to_s method that comes with Ruby, and how do you override this?
38) What are some important attributes of the to_s method?
39) From within a class, when an instance method uses self, what does it reference?



=end
