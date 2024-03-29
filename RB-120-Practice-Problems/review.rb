##### RB 120 OOP Review ####

# RB 129 Assesment Format
# Written:
# ~20 questions, 3 hours to complete.
# Interview:
# Explain concepts with precision while writing out code examples.

# Specific Topics of Interest
#x Classes and objects
#x Use attr_* to create setter and getter methods
#x How to call setters and getters
#x Instance variables, class variables, and constants, including the scope of each type and how inheritance can affect that scope
#x Instance methods vs. class methods
#x Method Access Control
#x Referencing and setting instance variables vs. using getters and setters
#x Class inheritance, encapsulation, and polymorphism
#x Modules
#x Method lookup path
#x self
#x Reading OO code
#x Fake operators and equality
#x Working with collaborator objects
#x Create a code spike # Practice these! 3 in the SPOT wiki. Showing object heirarchy.
#x Create code examples for different concepts.

# xOOP LS 120 Questions - Done
# xRB 129 Practice Problems - 

# Interview concepts to go over:
# OOP
# Classes
# Objects
# Instance variables, class variables, Constants
# Instance vs Class methods
# Inheritance, interface and class
# Encapsulation
# MAC
# Polymorhpism
# super
# modules
# MLP
# Namespace resolution operator
# OO Programming book

# Sample Problems from Ggcpinckert

# March 17th RB 129 Study Session
=begin
RB 129 assessment FORMAT
Written:
3 Hour time limit
Look at the last question!

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
# checks if the both objects are the same by object identity as it is using the default `object` class implementation of `==`

# In order to check equality via the instance variable names, we have to define a new `==` method inside the class.

attr_reader :name

def ==(other)
  name == other.name
end

# We would also have to create getter methods in order to access the name variable in the other object.

# 2)

# Tell us a little about `Method Access control` with a few examples.
# MAC is that exercise of using Public, private, and protected methods within a class's defintion.
# By default, all methods defined in a class are public. The means that the method can be called anywhere in the codebase.
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

######################## Spot Study session # 2 ########################

Have code examples for all different concepts, along with a written definition of each.

Method lookup path Class, modules from bottom of list, superclass.
Constant lookup path (lexical)

module FourWheeler
  WHEELS = 4
end

class Vehicle
  def maintenance
    "Changing #{FourWheeler::WHEELS} tires."
  end
end

class Car < Vehicle
  include FourWheeler

  def wheels
    WHEELS
  end
end

car = Car.new
puts car.wheels        # => 4 # finds the constant in the include module.
puts car.maintenance  # Throws an error as vehicle does not include FourWheeler. Could use namespace (::) operator to access from Fourwheeler

########## Code Spike Examples:

### Dental Office Alumni (by Rona Hsu)
There's a dental office called Dental People Inc.  Within this office, there's 2 oral surgeons, 2 orthodontists, 1 general dentist.
Both general dentists and oral surgeons can pull teeth. Orthodontists cannot pull teeth.  Orthodontists straighten teeth.
All of these aforementioned specialties are dentists. All dentists graduated from dental school.  Oral surgeons place implants.
General dentists fill teeth

Nouns: office, surgerons, orthodontists, dentist, 
Verbs: pull teeth, straighten teeth, place implants, fill teeth.

class Office; end

class Dentist < Office
  def initialzie(name, specialty)
    @name = name
    @speciality = specialty
    @dentalschool = true
  end
end

module PullTeethable
  def pull_teeth
  end
end

class OralSurgeron < Dentist
  include PullTeethable

  def initialize(name)
    super(name, self.class)
  end

  def place_implant
  end
end

class Orthodonsist < Dentist
  def initialize(name)
    super(name, self.class)
  end

  def straighten_teeth
  end
end

class GeneralDentist < Dentist
  include PullTeethable

  def initialize(name)
    super(name, self.class)
  end

  def fill_teeth
  end
end

####### Other version.

class DentalOffice 
  def initialize(name)
    @name = name 
    @dentist = populate_staff 
  end 

  def populate_staff
    staff = []
    2.times { staff << OralSurgeon.new}
    2.times { staff << Orthodontists.new} 
    staff << GeneralDentist.new 
    staff
  end 
end 

module  Pullable 
  def pull 
    "I can pull Teeth!"
  end 
  
end


class Dentist 
  def initialize
    @degree = 'Dental School Graduate'
  end 
end 

class OralSurgeon < Dentist 
  include Pullable

  def implants
    "I can implant Teeth!"
  end 
end 

class Orthodontists < Dentist

  def straighten
    'I can straighten Teeth!'
  end 
end 

class GeneralDentist < Dentist
  include Pullable

  def fill_teeth
    'I can fill teeth'
  end 
end 

p DentalOffice.new('Dental People Inc.')

=end

################################################################################################
###################### OOP Question RB 120 - LS 120 Questions ##################################
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

A mixin in when a module has been included into a class using the `include` method.

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

To instantiate a new object, you call `new` on the objects class, and pass to new any intiailzing arguments as required by the defined
`initialize` method.

20) What is a constructor method?

The constructor method is the `initialize` method, a special method called when a new object is instantiated.

21) What is an instance variable, and how is it related to an object?

Instance variables are variables tied to individual objects. They contain information regarding the objects state (ie: name, age, weight,etc..)
They are identified by starting with a single `@` symbol, and scoped at the object level.

22) What is an instance method?

Instance methods are methods available to all objects of that class. They are often referred to as behaviors of that class, and are actions
instances of that class can make.

23) How do objects encapsulate state?

Objects encapsulate state by the use of instance variables. Instance variables can contain anything, strings, arrays, intergers, other objects, etc.

24) What is the difference between classes and objects?

Classes are the defined mold of an object. They contain the instructions on data to retrieve when instantiating a new object, and the behaviors
available to that object.

Objects are created from classes, and contain individual states. Objects act on behaviors defined in the class.

25) How can we expose information about the state of the object using instance methods?

To expose information about an object, we use getter instance methods. Getter methods retrieve and often output the information stored
in an objects instance variables.

26) What is a collaborator object, and what is the purpose of using collaborator objects in OOP?

A collaborator object is an object that is stored as part of another objects state. The object can be any type of object.
Collaborator objects can often identify intended relationships between different objects in our code.

# Page 2

27) What is an accessor method?

An accessor method is a method created to either return or set the value of an objects instnace variable. Ruby convention states the method
name should be the same as the instance variable itself, adding a `=` for the setter method. Ruby's syntactical sugar allows for setter
methods to be called in very reader friendly manner, obj.name = "new_name" instead of obj.name=("new_name").

28) What is a getter method?

A getter method is a method written to retrieve and often output the value of an instance variable.

29) What is a setter method?

A setter method is a method used to assign a value to an objects instance variable. Typically written as `varname=(newname)`, ruby's syntactical
sugar allows for the method to be called as so: obj.name = "Steve".

30) What is attr_accessor?

An accessor method is a method created using `attr_accessor` followed by a symbol of the instance variable. `attr_accessor` creates
getter and setter methods for the instance variable listed as symbol, and will also initialize the instance variable if not already
defined.

If we wanted to create just a getter method, we can use `attr_reader` or `attr_writer` for just a setter method.

31) How do you decide whether to reference an instance variable or a getter method?

In general it's best practice to use the getter method when referencing an instance variable. Using the getter method helps to maintain
a consistent output for the variable in your code, and allows you to better manage the many locations it may be output. It also allows
you to hide the raw data from the output.

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

In the above example, in the change_info method, the name, height, and weight assignments are occuring to newly created variables
created at the local method scope. In order for us to instead call the setter methods, we must first prepend `self` to the method calls
so that the code knows we're calling the instance method, and not initializing a new local variable.

33) When would you call a method with self?

We call a method with `self` to disambiguate from initializing or referencing local variable of the same name. `self` tells ruby
that we care calling the method.

The other use for `self` is when defining class methods. We prepend the method name with `self` in the class definition to indicate we are
calling the method on the class itself.

34) What are class methods?

Class methods are method which are called on the class itself, without having to instantiate any objects. Class methods are where we put
functionality that does not pertain to any individual object. Class methods can be used to output class variables, or information about the class.

35) What is the purpose of a class variable?

Class variables contain information that is relevant to the whole class. Things like the number of objects of the class that have been created,
or general data that may be applicable to all intances of the class. Class methods are defined with two @ symbols and must be initialized
at class creation time.

36) What is a constant variable?

Constants are variables that we never want to change. Constants are defined using all upper case letters, CONSTANT. 

37) What is the default to_s method that comes with Ruby, and how do you override this?

By default, `to_s` will output the object class, and encoding of the object ID (it's space in memmory).

To override this, we need to define a new `to_s` method within our class.

`to_s` is important as it is called automatically anytime we call `puts` on an object, and used in string interpolation.

38) What are some important attributes of the to_s method?

`to_s` is called when you use `puts`, and also in string interpolation.

39) From within a class, when an instance method uses self, what does it reference?

From within a class and used inside an instance method, self refers to the instance(object) itself.

# Page 3

40) What happens when you use self inside a class but outside of an instance method?

Using `self` inside a class, but outside of an instance variable, `self` refers to the class itself.

41) Why do you need to use self when calling private setter methods? ********

When calling private setter methods, it's important to use self to differentiate between initializing a new local variable vs changing
the existing instance variable of the calling object.

42) Why use self, and how does self change depending on the scope it is used in?

We use self whenever we are calling an instnace method from within the class. `self` changes depending on it's scope by representing different
objects. Used inside of an instance variables it represents the calling object. Used inside of the class but outside of an instance method
it represents the class itself and is used to define a class method.

43) What is inheritance, and why do we use it?

Inheritance is when a class inherits the behaviors of a parent (superclass) class, or inherits behaviors from a module (interface inheritance).

44) Give an example of how to use class inheritance.

class Animal

end

class Dog < Animal

end

The Dog class will inherit all behaviours of the `Animal` class.

45) Give an example of overriding. When would you use it?

Using our previous example, if Animal had a `move` method which made the animal walk, but our `dog` class should `run` instead of `walk`,
we could define a new `move` method in teh `dog` class to change the behavor for the dog.

class Animal
  def Move
    "Walk"
  end
end

class Dog < Animal
  def Move # This method will override the `animal#Move` method thanks to Rubys method look up path.
    "Run"
  end
end

46) Give an example of using the super method. When would we use it?

Class Animal
  def intialize(age)
    @age = age
  end
end

Class Dog < Animal
  def initialize(age)
    super # program flow moves to superclass `initialize` method and passes all arguments by default.
  end
end

47) Give an example of using the super method with an argument.

Class Animal
  def intialize(age)
    @age = age
  end
end

Class Dog < Animal
  def initialize(age, breed)
    super(age) # passes to super, so that our dog object has a @age instance variable, passes along the required argument as well.
    @breed = breed
  end
end

48) When creating a hierarchical structure, under what circumstance would a module be useful?

A module is beneficial when some subclasses of a superclass, but not all, exhibit a particular behavior. Mixing in a module helps keep code DRY
and allows the code to be reused in various different subclasses. Modules typically use a "able" suffix on whatever verb best describes the
behavior.

49) What is interface inheritance, and under what circumstance would it be useful in comparison to class inheritance?

Interface inheritance is when mixin modules are used. Interface inheritance is useful when multiple, but not all, subclasses exhibit 
a behavior.

50) How is the method lookup path affected by module mixins and class inheritance?

mixin modules add areas for ruby to search for a method, before moving on to the objects superclass.

The method look up path begins in the class, then the included modules from the bottom of the list first, then the superclass and it's mixin modules, etc.

51) What is namespacing?

Namespacing is using modules to group together similar classes under one module.

52) How does Ruby provide the functionality of multiple inheritance?

Ruby is a single inheritance language, meaning that classes can only subclass from 1 superclass. In order to work around this
we can use mixin modules to add extra functionality to different classes by mixing in modules. A c;ass can mix in as many modules as it likes.

53) Describe the use of modules as containers.

Modules as containers are when modules contain behaviors (methods) that need to be used accross the program in a manner that doesn't align 
exactly with the class hierarchial structure. This is very helpful for when methods may seem out of place for
a class heirarchal system, but may be requried in mutliple places in your code.

54) Why should a class have as few public methods as possible?

Having as few public methods as possible helps us simplify using that class and protects the data from undesired changes and exposure
from the public interface.

55) What is the private method call used for?

A private method are methods that can only be used from within the class definition and are not able to be called from outside.

56) What is the protected keyword used for?

The protected keyword is used to indicate to ruby that any method below the keyword is protected. Protected methods are those which
are similar to private methods, but that they allow access between class instances (in comparison for example).

57) What are two rules of protected methods?

They can not be invoked outside of the class, and other instances of the class can invoke the method.

58) Why is it generally a bad idea to override methods from the Object class, and which method is commonly overridden?

Overriding `object` class methods is generally a bad idea as the overriding method is often not the desired method to call. This can lead
to problems debugging code, and often leads to argument errors.

`to_s` is a commonly overridden object class method.

59) What is the relationship between a class and an object?

A Class is the mold of the object. The object will contain invidual state information, while the class will outline the states to track
and contain it's behaviors.

60) Explain the idea that a class groups behaviors.

The idea that class groups behaviors is that the class will contain all of the methods available to all instances of that class.
All objects of the class can perform the same actions.

61) Objects do not share state between other objects, but do share behaviors

Objects all share access to the same instance methods, but do no share their instance variables which store their individual state.

62) The values in the objects' instance variables (states) are different, but they can call the same instance methods (behaviors)
 defined in the class.

63) Classes also have behaviors not for objects (class methods).

Class methods are defined by appending `self` to the method name.

64) sub-classing from parent class. Can only sub-class from 1 parent; used to model hierarchical relationships
mixing in modules. Can mix in as many modules as needed; Ruby's way of implementing multiple inheritance

Sub classing is typically a "is_a" relationship, while mixin modules are used for a "has_a" relationship.

# Page 4

65) understand how sub-classing or mixing in modules affects the method lookup path

Ruby will first search the class for the method, then the mixin module list from bottom to top, then the superclass and it's modules.

66) What will the following code output?

class Animal
  def initialize(name)
    @name = name
  end

  def speak
    puts sound
  end

  def sound
    "#{@name} says "
  end
end

class Cow < Animal
  def sound
    super + "moooooooooooo!"
  end
end

daisy = Cow.new("Daisy")
daisy.speak

#=> Daisy says mooooooooooooo!

67) 
class Person
  attr_writer :first_name, :last_name

  def full_name
    # omitted code
    puts "#{@first_name} #{@last_name}" # added this line. or # @first_name + " " + @last_name
  end
end

mike = Person.new
mike.first_name = 'Michael'
mike.last_name = 'Garcia'
mike.full_name # => 'Michael Garcia'

What code snippet can replace the "omitted code" comment to produce the indicated result? 

68)
class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = nil
  end

  def change_grade(grade) # add this
    self.grade = grade
  end
end

priya = Student.new("Priya")
priya.change_grade('A')
p priya.grade # => "A"

The last line in the above code should return "A". Which method(s) can we add to the Student class so the code works as expected?

# Page 5

69)
In the example above, why would the following not work?

def change_grade(new_grade)
  grade = new_grade
end

The above code would be initializing a new locally scoped variable "grade" within the method and not reassigning the instance variable @grade
or using the setter grade= method.

70)
On which lines in the following code does self refer to the instance of the MeMyselfAndI class referenced by i rather 
than the class itself? Select all that apply.

class MeMyselfAndI
  self

  def self.me
    self
  end

  def myself
    self #instance
  end
end

i = MeMyselfAndI.new

Line 842 only.

71)
Given the below usage of the Person class, code the class definition.

bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

72)
Modify the class definition from above to facilitate the following methods. Note that there is no name= setter method now.

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

Hint: let first_name and last_name be "states" and create an instance method called name that uses those states.

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    names = name.split(' ')
    @first_name = names.first
    @last_name = names.size > 1 ? names.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

73)
Now create a smart name= method that can take just a first name or a full name, and knows how to set the first_name and last_name appropriately.

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    names = name.split(' ')
    @first_name = names.first
    @last_name = names.size > 1 ? names.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    names = full_name.split(' ')
    @first_name = names.first
    @last_name = names.size > 1 ? names.last : ''
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
bob.first_name            # => 'John'
bob.last_name             # => 'Adams'

# Page 6

74) Using the class definition from step #3 (73), let's create a few more people -- that is, Person objects.

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?

#=> bob.name == rob.name

This will use the string values in instance variables @name, and using string#== to compare.

75) Continuing with our Person class definition, what does the below print out?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}" #=> The person's name is: <Person:OBJECT ID>

76) Let's add a to_s method to the class:

class Person
  # ... rest of class omitted for brevity

  def to_s
    name
  end
end
Now, what does the below output?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}" #=> "The person's name is : Robert Smith"

77) Create an empty class named Cat.

class Cat; end

78) Using the code from the previous exercise, create an instance of Cat and assign it to a variable named kitty.

class Cat; end

kitty = Cat.new

79)
class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Chef
        preparer.prepare_food(guests)
      when Decorator
        preparer.decorate_place(flowers)
      when Musician
        preparer.prepare_performance(songs)
      end
    end
  end
end

class Chef
  def prepare_food(guests)
    # implementation
  end
end

class Decorator
  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_performance(songs)
    #implementation
  end
end

# The above code would work, but it is problematic. What is wrong with this code, and how can you fix it?

The above `prepare` method has too many dependencies. It relies on specific class and their names, and need to know which method it
should call for each object, along with the appropriate argument the methods require.

We can change the implementation so that each class has a `prepare_wedding` method, which calls the method they require. We'll pass
in `self` as the argument, and gather the required information for the method implementation at each class level.

# Page 7

80) What happens when you call the p method on an object? And the puts method?

Calling `p` on an object will return : <Object_class_name: followed by an encoding of the object ID, and any instance variables and their values.
Calling `puts` on an object will return : <Object class name: follow by an encoding of the object ID>

81) What is a spike?

A Spike is exploratory code to play around with the problem.

82) When writing a program, what is a sign that you’re missing a class?

repetive nouns in method names are a sign that you're missing a class. ie: "format_move(human.move)" instead of
`human.move.display`

83) What are some rules/guidelines when writing programs in OOP?
-When naming methods, don't include the class name. ie: player.info, instead of player.player_info
-Avoid long method invocation chains.
-Avoid design patterns for now.

84)
class Student
  attr_accessor :grade

  def initialize(name, grade=nil)
    @name = name
  end
end

ade = Student.new('Adewale')
ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">
# Why does this code not have the expected return value?

ade will return "Student:encoding of object id, and @name ='Adewall'"

As the `grade` instance variable is not initialized, the `ade` object does not yet contain that state.
Calling ade.grade return nil, not because it's default value is `nil`, but because it has yet to be initialized.

85)
class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} is speaking." # Change to `name`. this will instead call the `name` method of the calling object, which is a Knight.
  end
end

class Knight < Character
  def name
    "Sir " + super
  end
end

sir_gallant = Knight.new("Gallant")
sir_gallant.name # => "Sir Gallant"
sir_gallant.speak # => "Sir Gallant is speaking."
# What change(s) do you need to make to the above code in order to get the expected output?

Change on line 1067

# Page 8

86)
class FarmAnimal
  def speak
    "#{self.class} says " #add .class to self.
  end
end

class Sheep < FarmAnimal
  def speak
    super + "baa!"
  end
end

class Lamb < Sheep
  def speak
    super + "baaaaaaa!" # Add super.
  end
end

class Cow < FarmAnimal # Add FarmAnimal class inhertiance
  def speak
    super + "mooooooo!"
  end
end

p Sheep.new.speak # => "Sheep says baa!"
p Lamb.new.speak # => "Lamb says baa!baaaaaaa!"
p Cow.new.speak # => "Cow says mooooooo!"
# Make the changes necessary in order for this code to return the expected values.

87)
class Person
  def initialize(name)
    @name = name
  end
end

class Cat
  def initialize(name, owner)
    @name = name
    @owner = owner
  end
end

sara = Person.new("Sara")
fluffy = Cat.new("Fluffy", sara)
Identify all custom defined objects that act as collaborator objects within the code.

The person object `Sara` is a collaborator object, as it's used in an instance variable in fluffy.

# Page 9

88) How does equivalence work in Ruby?

For most objects, the `==` operator compares the values of the objects, and is most frequently used. The `==` operator is actually a 
method defined in the BasicObject class, and overridden in most built in ruby classes. The basicobject `==` method actually checks if
the two objects are the same object.

89) How do you determine if two variables actually point to the same object?

Checking if variables point to the same object, we can use `equal?`

90) What is == in Ruby? How does == know what value to use for comparison?

`==` in ruby is actually a defined method. Most classes have a defined `==` method indicating what values to use for comparison.

91) Is it possible to compare two objects of different classes?

Yes, as `==` can be implemented however you wish. This is seen in `Interger#==` and `float#==` as they can both handle comparison
of integers against floats and vice versa.

92) What do you get “for free” when you define a == method?

The `!=` (not equals) method.

93)
arr1 = [1, 2, 3]
arr2 = [1, 2, 3]
arr1.object_id == arr2.object_id      # => ?? false

sym1 = :something
sym2 = :something
sym1.object_id == sym2.object_id      # => ?? True

int1 = 5
int2 = 5
int1.object_id == int2.object_id      # => ?? True
# What will the code above return and why?

Symbols and integers include a performance optimization where if they have the same value, they are also the same object. This is because
symbols and integers are immutable, and can't be modified.

94) What is the === method?

the `===` method is similar to `==` in that it is also an instance method, but the `===` method checks wether the left side group
would contain the right side comparison.

String (class) === "hello" #=> True, "Hello" is an instance of the String class.
String (class) === 15 #=> False, integer 15 is not an instance of String

95) What is the eql? method?

The `eql?` method checks if both objects are the same object, and contain the same value.

96) What is the scoping rule for instance variables?

Instance variables are scoped at the object level. This means that the instance variable is accessible in an objects instance methods,
even if initialized outside of that method.

97)
class Person
  def get_name
    @name                     # the @name instance variable is not initialized anywhere
  end
end

bob = Person.new
bob.get_name                  # => ??
# What is the return value, and why?

The code would return `nil`. This is because the instance variable is not initialized anywhere in the code, and uninitialized instance variables
will not raise a NameError.

98) What are the scoping rules for class variables? What are the two main behaviors of class variables?

Class variables are scoped at the object level. All class objects share 1 copy of the class variable.
Class methods can access class variables provided the clrass variable has been initalized prior to calling the method.

99) What are the scoping rules for constant variables?

Constants have a lexical scope. This means that Ruby will search the surrouding strucutre or the constant reference.

100) How does sub-classing affect instance variables?

Subclasses can access instance variables in supercalsses providing the variable has been initialzied, the same occurs with interface inheritance
by mixin modules, prodiving the method intializing the variables has been called before trying to access it.

# Page 10

101)
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
puts teddy.dog_name                       # => ??
# What will this return, and why?

This code will return "bark! bark!  bark! bark!" as the @name instance variable is not initialized and will return nil. 
As the Dog class intiailize method does not pass to the Animal class initialize method via super, the @name variable is not assigned `Teddy`.

102)
module Swim
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swim

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
teddy.swim                                  
# How do you get this code to return “swimming”? What does this demonstrate about instance variables?

In order for this code to return `swimming`, we must first call `teddy.enable_swimming` to initialize the @can_swim` variable to true

103) Are class variables accessible to sub-classes?

Yes, they are accessible to subclasses and is the reason why it's suggested to avoid class variables when working with inheritance.

104) Why is it recommended to avoid the use of class variables when working with inheritance?

It's recommended to avoid using class variables when working with inheritance as there is only one copy of the variable available 
to all subclasses.

105)
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

Vehicle.wheels                              # => ?? 4

class Motorcycle < Vehicle
  @@wheels = 2
end

Motorcycle.wheels                           # => ?? 2
Vehicle.wheels                              # => ?? 2

class Car < Vehicle
end

Car.wheels                                  # => ?? 2
# What would the above code return, and why?

On line 1289, we are reassinging the class variable wheels in Vehicle to 2, all future calls to @@wheels made in vehicle or it's subclasses will
reference this new updated @@wheels value.

# Page 11

106) Is it possible to reference a constant defined in a different class?

In order to reference a constant defined in a diferrent class which is not an ancestor, we can use the namespace resolution operator (::).

107) What is the namespace resolution operator?

The namespace resolution operator `::` allows you to reach into other classes that are not in scope to reference constants.

108) How are constants used in inheritance?

Ruby will traverse up the inheritance heirarchy of the structure that references the constant.

109)
module Maintenance
  def change_tires
    "Changing #{WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
end

a_car = Car.new
a_car.change_tires
# Describe the error and provide two different ways to fix it.

# The code raises an error due to the call to the Vehicle constant WHEELS. In order to fix this we can use namespace resolution operator
# and change the reference to Vehicle::WHEELS.

110) What is lexical scope?

Lexical scope is searching the surrounding structure for the reference.

111) When dealing with code that has modules and inheritance, where does constant resolution look first?

Constant resolution first searches lexically, then the inheritance chain in the normal manner class first then modules from bottom to top.

112)
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other)
    age > other.age
  end
end

bob = Person.new("Bob", 49)
kim = Person.new("Kim", 33)
puts "bob is older than kim" if bob > kim

In order to make this code work, we need to create a > method within the Person class
def >(other)
  age > other.age
end

113)
my_hash = {a: 1, b: 2, c: 3}
my_hash << {d: 4}  
# What happens here, and why?

An error is raised here for undefined method, as `<<` is actually a defined method and not an operator.

# Page 12

114) When do shift methods make the most sense?

Shift methods make sense when dealer with a class that represents a collection. When impltementing fake operators, choose some functionaility
that makes sense when used.

115)
  class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    members + other_team.members
  end
end

# we'll use the same Person class from earlier

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)

niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
dream_team = cowboys + niners               # what is dream_team?
# What does the Team#+ method currently return? What is the problem with this? How could you fix this problem?
The Team+ method currently returns a new array of players. That may be fine, but if we instead wanted to return a new team object we'd need
to make some changed.

def +(other_team)
  temp_team = Team.new('Temprorary team')
  temp_team.members = members + other_team.members
  temp_team
end

116) Explain how the element getter (reference) and setter methods work, and their corresponding syntactical sugar.

Element getter and setter methods are given extreme use of ruby's syntactical suger. The Array element reference provides a great example:
Arr = [1,2,3]

arr[1] = 2, which is eactually a call to arr.[](1) = 2

The setter method is more extreme:
arr[1] = 4 # Arr = [1,4,3]
Is actually a call to:
arr.[]=(1, 4) # Arr = [1,4,3]

117) How is defining a class different from defining a method?

When defining a class, we used the class keyword followed by the class name in CamelCase, rather than `def` and snake_case

118) How do you create an instance of a class? 
  
By calling the class method `new`

119) What are two different ways that the getter method allows us to invoke the method in order to access an instance variable?

Inside the class, we can just call the getter method, or outside the class, we can call the method on an instance of the class.

120) When you have a mixin and you use a ruby shorthand accessor method, how do you write the code (what order do
   you write the getter/setters and the mixin)? What about using a constant?

In the class definition, the mixin goes above accessor, and the constant goes above accessor

121) How do you define a class method?

Define a class method by prepending `self` to the method name.

122)
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def rename(new_name)
    name = new_name
  end
end

kitty = Cat.new('Sophie')
p kitty.name # "Sophie"
kitty.rename('Chloe')
p kitty.name # "Chloe"
# What is wrong with the code above? Why? What principle about getter/setter methods does this demonstrate?

In the imethod `rename`, we need to prepend `self` to `name` on line 9, otherwise Ruby assumes we’re
initializing a new local variable `name` and assigning it to the argument passed in through the parameter `name`. 

# Page 13

123) Self refers to the ______ _______.

The calling object.

124) How do you print the object so you can see the instance variables and their values along with the object?

To print the object, an encoding of it's object ID, and it's instance variables, use `p`

125) When writing the name of methods in normal/markdown text, how do you write the name of an instance method? A class method?

`ClassName#instance_method_name`, `ClassName::class_method_name`

126) How do you override the to_s method? What does the to_s method have to do with puts?

You can override the to_s method by defining a to_s method in the relevant class. `puts` automatically calls `to_s` when outputting an object. 

127)# Using the following code, allow Truck to accept a second argument upon instantiation. Name the parameter bed_type and implement
 the modification so that Car continues to only accept one argument.

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  def initialize(year, bed_type)
    super(year)
    @bed_type = bed_type
  end
end

class Car < Vehicle
end

truck1 = Truck.new(1994, 'Short')
puts truck1.year
puts truck1.bed_type

# Page 14

128)
# Given the following code, modify #start_engine in Truck by appending 'Drive fast, please!' to the return value of #start_engine 
in Vehicle. The 'fast' in 'Drive fast, please!' should be the value of speed.

class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + “Go #{speed} please!”
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')

# Expected output:

# Ready to go! Drive fast, please!

129) When do you use empty parentheses with super?

When you want to invoke a superclass methods and explicitly pass no arguments to the superclass method (to prevent an argument error)

130) How do you find the lookup path for a class? (lookup path stops when you find it)

Call the ancestors method on the class

131) What is namespacing, and how do you instantiate a class contained in a module?

Namespacing is grouping related classes, perhaps to prevent similarly named methods from colliding. You can instantiate a
 class contained in a module by using the namespace resolution operator, :: (Module::Class.new)

132) When using getters and setters, in what scenario might you decide to only use a getter, and why is this important?

You might only need a getter if you only want to access the data, but don’t want or need to be able to change it. 

133) When might it make sense to format the data or prevent destructive method calls changing the data by using a custom
 getter or setter method?

Any time you want to control how the user is able to access or change data - getters and setters protect the raw data

=end


# Code Examples:
########################################################################
######################## Required code examples:########################
########################################################################

=begin
# **Polymorphism through inheritance**

class Food
  def bake
  end
end

class Bread < Food
  def bake
    puts "I'm rising!"
  end
end

class Roast < Food
  def bake
    puts "I'm roasting!"
  end
end

class Flour < Food; end
class Sugar < Food; end

foods = [Bread.new, Roast.new, Flour.new, Sugar.new]
foods.each {|food| food.bake}

# **Polymorphism through duck-typing:**

class Concert
  attr_reader :songs, :lights, :stage

  def run(personel)
    personel.each do |person|
      person.perform_concert(self)
    end
  end
end

class Musician
  def perform_concert(concert)
      play_music(concert.songs)
  end

  def play_music(songs)
    # implementation...
  end
end

class Security
  def perform_concert(concert)
    secure_stage(conert.stage)
  end

  def secure_stage(concert)
    #implementation...
  end
end

class StageHands
  def perform_concert(concert)
    adjust_lights(concert.lights)
  end

  def adjust_lights(lights)
    #implementation...
  end
end

# **Encapsulation (using method access control)**

class Bike
  attr_reader :modelname

  def initialize(model)
    @modelname = model
  end

  def change_model(model)
    self.modelname = model
  end

  def model
    "This bike a #{modelname}."
  end

  private
    attr_writer :modelname #modelname setter method can only be called from within the class defintion.
end

trek = Bike.new('Trek')
trek.change_model('Specialized')
puts trek.model #=> "This bike is a Specialized."
trek.modelname = "Trek" # Error, private method `modelname=` called.

# **Class inheritance**

class Animal
end

class Dog < Animal
end

class Cat < Animal
end

# **Module mixins**

module Walkable
  def walk
    "Walking!"
  end
end

class Hunman
  include Walkable
end

class Animal
  include Walkable
end

# **self**

class Human
  attr_writer :name
  
  def self.what_am_i? # self, indicating a class method. Can be called on the class itself.
    "I'm a human!"
  end

  def change_name(new_name)
    self.name = new_name # self, represents the calling object.
  end
end

# **Super**

class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name)
    super # Passes all arguments to `initialize` method in superclass Animal.
    @type = self.class
  end
end

gryff = Dog.new('Gryff') #=> <Dog:encoding_of_object_id @name='Gryff', @type=Dog>

# **How do you implement a fake operator in a custom class?**

class Dog
  attr_accessor :name

  def +(other) # Fake operator defined within custom class.
    self.name + other.name
  end
end

# **Collaborator** **objects**

class Human
  attr_reader :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(x)
    self.pets << x
  end
end

class Pet
  def initialize(name, type)
    @name = name
    @type = type
  end
end

steve = Human.new('Steve')
p steve.pets #=> empty array
gryff = Pet.new('Gryff', 'Dog')
steve.add_pet(gryff)
p steve.pets #=> [<pet:encoding, @name = 'Gryff', @type = 'Dog'>]

# Accidental variable assignment instead of method invocation

class Car
  attr_accessor :model, :mileage

  def initialize(model, mileage)
    @model = model
    @mileage = mileage
  end
 
  def increment_mileage(miles)
    new_mileage = mileage + miles
    mileage = new_mileage # Initiailizing a new local variable `mileage` rather than calling the setter `mileage` method. Prepend `self.` to use the setter.
  end
end

mazda = Car.new('az', 100)
p mazda #=> <Car:encoding-of-object-id @model='az', @mileage=100>
mazda.increment_mileage(100) # Method is broken.
p mazda #=> <Car:encoding-of-object-id @model='az', @mileage=100>

# Instance variables initialized from Modules

module Swimmable
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swimmable

  def swim
    "swimming!" if @can_swim
  end
end

class Cat
  include Swimmable

  def swim
    "swimmer" if @can_swim
  end
end

teddy = Dog.new
teddy.enable_swimming # The @can_swim instance variable is initialzied uniquely for the teddy Dog object, but not any other
# dog objects or the Cat object.
p teddy.swim

ruffus = Dog.new
p ruffus.swim

cat = Cat.new
p cat.swim

=end

=begin

# Code Example of different concepts

# OOP

class NewClass; end

object = NewClass.new

p object

# Classes

class NewClass2
  def initialize(name) # Constructor `initialize` method with a parameter for `name` to initialize the `@name` instance variable.
    @name = name
  end
end

# NewClass2 is the mold for any objects we create of that class. The initialize constructor method is called when we 
# instantiate a new object, and initializes the objects instance variables to the values passed in.

object2 = NewClass2.new('steve2') #instantiating a new `NewClass2` object, and passing in an argument for `name` parameter.

p object2 #=> <NewClass2:encoding_of_object_id @name=`steve2`>

# Objects

class NewClass3 < NewClass2
  attr_reader :name # getter method for instance variable defined in a class inherited `initialize` method works. Instance variables
  # are scoped at the object level, therfor value for getter method is in scope.

  def move
    "#{name} is rolling!" # can be either @name or `name` as we've defined a getter method.
  end
end

object3 = NewClass3.new('steve3') # Uses class inheritance to inherit the `initialize` method from `NewClass2`

p object3 #=> <NewClass3:encoding_of_object_id @name=`steve3`>

p object3.move #=> steve3 is rolling! # Calls the `move` method defined in `NewClass3`, which using string interpolation to 
# include the `@name` value in the output string.

# Instance variables, class variables, Constants

CONST = "OUTSIDE"

class NewClass4 < NewClass3
  @@classvar = "I'm a class var!"

  def const # Instance method to call the CONST constant.
    CONST
  end

  def self.show_class_var
    @@classvar
  end

  def show_my_class_var
    @@classvar
  end

  def name #getter method to show instance variable
    @name
  end
end

object4 = NewClass4.new('steve4')

p object4 #=> <NewClass4:encoding_of_object_id @name='steve4'>
p object4.name #=> steve4
p object4.const #=> OUTSIDE
p NewClass4.show_class_var #=> I'm a class var! # class method returning the class variable
p object4.show_my_class_var #=> I'm a class var! # instnace method returning the class variable.

# Instance vs Class methods

class NewClass5 < NewClass4
  def self.i_am_a_class_method
    "A class method of the NewClass5 class!"
  end

  def i_am_a_instance_method
    "I'm an object of a #{self.class}"
  end
end

object5 = NewClass5.new('steve5')

p NewClass5.i_am_a_class_method
p object5.i_am_a_instance_method

# Inheritance, interface and class

module Jumpable
  def jump
    "Jumping!"
  end
end

class NewClass6 < NewClass5 # class inheritance
  include Jumpable # interface inheritance

  def dance
    "Dancing"
  end
end

object6 = NewClass6.new('steve6')

p object6.jump # Instance method inherited from module `Jumpable`
p object6.i_am_a_instance_method # instance method inherited from superclass `NewClass5`

# Encapsulation

class Capsulating
  attr_reader :name

  def initialize(name, sin)
    @name = name
    @sin = sin
  end

  def show_sin
    "xxx-xxx-" + sin[-4,4]
  end

  private

  attr_reader :sin
end

# This demonstrates using method access control for encapsulation. Hiding bits of functionality from the user interface.
# To display the objects `sin`, we can not call the getter method directly, instead we call `show_sin` which only displays
# the last 4 digits of the users sin number.

# Meanwhile, we have the public `name` getter method which can be aclled directly from the public interface.

steve = Capsulating.new('steve', '123-123-1234')

p steve.show_sin #=> xxx-xxx-1234
p steve.name #=> steve

# MAC

# All methods defined in a class are by default `public` until an access modifier keyword is used.

class Mac
  def initialize(age)
    @age = age
  end

  def ==(other)
    age == other.age
  end

  protected # if this were private, the `==` comparison method would not be able to retrieve the `age` of the `other` object.

  attr_reader :age
end

mac1 = Mac.new(10)
mac2 = Mac.new(20)
mac3 = Mac.new(10)

p mac1==mac2 #=> false
p mac1==mac3 #=> true

# Polymorphism

# Polymorphism is the ability for different types of data to respond to a common interface. Enables different object types to
# to respond to a common method call. This can be achieved through inheritance or Ducktyping.

# Inheritance would be by ensure that all different objects have access to a method of a common name, and have different
# executions of the method. This is done by method overriding, and defining a gereral purpose method in the superclass,
# then altering the methods execution in each of the subclasses.

# Through duck typing, we are ensuring that all different unrelated types of objects respond to the same method name. We do this
# by defining a common method name in each class, that takes the same number of arguments, and within that method calling the appropriate
# methods for that particular class's execution of the method.

# Example of Inheritance
class Human
  def talk
    "Talking"
  end
end

class Adult < Human
  def talk
    "Inteligent talking!"
  end
end

class Baby < Human
  def talk
    "Indistinct crying"
  end
end

[Human.new, Adult.new, Baby.new].each {|human| p human.talk}

# Example of duck typing

class Concert
  def show(people)
    people.each do |people|
      people.run_show(self)
    end
  end
end

class Singer
  def run_show(concert)
    sing
  end

  def sing
    p "Singing!"
  end
end

class Dancer
  def run_show(concert)
    dance
  end

  def dance
    p "Dancing at the show"
  end
end

people = [Singer.new, Dancer.new]

Concert.new.show(people)

# super

# The `super` keyword is provided by ruby to divert the program flow to a previously defined method in the method lookup path.
# This can be useful for constructor methods, or any method where we wish to inherit a previously defined methods behavior
# but add extra executions within the called method.

class Human
  def initialize(name)
    @name = name
  end
end

class Adult < Human
  def initialize(name) # parameter to be passed to super must be defined in local method.
    super # By default, passes all arguments up to the previously defined method.
    @type = 'Adult'
  end
end

steve = Adult.new('steve') # Passing in `steve` argument to pass to `super`.

p steve #=> <Adult:encoding_of_object_id @name=`steve`, @type=`Adult`>

# modules

# Modules can be used for; namespacing, containers, and mixin modules. 

# Namespacing is when we use modules to group similar classes together, and is particularly helpful in large codebases to avoid
# accidental interference between similarly named classes.

module Humans
  class Child; end

  class Adult; end
end

child = Humans::Child.new
adult = Humans::Adult.new

p child #=> <Humans::Child:encoding of object id>
p adult #=> <Humans::Adult:encoding of object id>

# child2 = Child.new # return an error, as `Child` class is not in scope.

# Modules used as containers simply house methods that seem out of place within the codebase.

module Conversion
  def self.mph_to_kpb(num)
    num * 1.6
  end
end

valinkph = Conversion.mph_to_kpb(10)
p valinkph #=> 16.0

# Lastly, modules can be used to mix in behaviors(methods) that will be shared accross multiple classes but don't
# align with the class inheritance structure. These are typically named in a "-able" fashion ie: "Walkable"

module Walkable
  def walk
    "Walking!"
  end
end

class Dog
  include Walkable
end

p Dog.new.walk #=> "Walking!"

# MLP

# The method lookup path is the path in which ruby looks through to resolve the method call. Ruby will first search the calling
# objects class, then any mixin modules from last included to first, then the inheritance structure.

module Barkable; end
module Scratchable; end

class Animal
  include Walkable
end

class Racoon < Animal
  include Barkable
  include Scratchable
end

p Racoon.new.walk #=> Walking!
p Racoon.new.class.ancestors #=> Racoon, Scratchable, Barkable, Animal, Walkable (find `walk`), object, kernel, basicobject

# Namespace Resolution operator (::)

# The namespace resolution operator can be used to help direct ruby search to resolve a constant.
# If the constant is not defined within the lexical scope, we can tell ruby where to find it.

class Computer
  GREETINGS = ['hi', 'hello']
end

class Laptop
  def greet
    Computer::GREETINGS.sample # Tells ruby to get `GREETINGS` from `Computer` class.
    # GREETINGS.sample # Will raise an error as GREETINGS is  not in scope.
  end
end

p Laptop.new.greet #=> "hello" or "hi"

=end

# Warmup:
=begin

module Talkable
  def talk
    "#{name} I can talk!" # Use of `attr_reader` getter method to interpolate the `name` instance variable into the string.
  end
end

class Admin
  MAJOR2 = "I'm out of scope for methods in the Teacher class, but you can reach in and get me!"
end

class Teacher
  include Talkable
  attr_accessor :name, :gender # Accessor methods, define getter and setter methods
  
  MAJOR = "I'm the const"

  @@num_of_teachers = 0

  def initialize(name, age)
    @name = name # Instance variable initialization.
    @age = age
    @@num_of_teachers += 1
  end

  def teach # Instance method defined in `Teacher`
    "I'm teaching!"
  end

  def self.number_of_teachers
    @@num_of_teachers
  end

  protected

  attr_reader :age
end

class GeographyTeacher < Teacher

  def initialize(name, age)
    super # Example of call to `super`, all arguments are passed up the chain by default.
    @subject = 'Geography'
    @books = []
  end

  def teachmaps # Instance method defined in `GeographyTeacher` class.
    "I'm talking about maps!"
  end

  def what_do_i_teach?
    "My name is #{name} and I'm a #{subject} teacher."
  end

  def ==(other)
    self.age == other.age
  end

  def addbook(book)
    self.books << book
  end

  def printtheconsts
    MAJOR
    Admin::MAJOR2 # Namespace resolution operator used to reach in to out-of-scope Admin class for MAJOR2 constant.
  end

  private

  attr_accessor :books
  attr_reader :subject

end

class Book
  def initialize(name, subject, pages)
    @name = name
    @subject = subject
    @pages = pages
  end
end

prof = GeographyTeacher.new('Steve', 22)
teach = GeographyTeacher.new('Jon', 22)
geo101 = Book.new('Geography maps', 'Geography', 150)

p prof.name # use of accessor method :name
p prof.teach # Call to `teach`, method is accessible as `GeographyTeacher` subclasses from the `Teacher` superclass.
p prof.teachmaps # Call to `GeographyTeacher::teachmaps`
p prof.talk # Call to `talk` method defined in mixin module `Talkable`, which is mixed in
# `GeographyTeacher` superclass `Teacher`
p prof.class.ancestors #=> GeographyTeacher, Teacher, Talkable, Object, Kernel, BasicObject
prof.name = 'Ralf' # Use the attr_accessor setter method to change `prof`s `name` instance variable.
p prof.name #=> Ralf
# p prof.subject # Raises a nomethoderror, calling a private method.
p prof.what_do_i_teach? #=> My name is Ralf and I'm a Geography teacher.
p prof == teach #=> true, uses the protected `age` getter method to compare ages.
# p prof.age # Error, calls a protected method.
p Teacher.number_of_teachers #=> 2 # Calling a class method to return a class variable tracking the number of instances of a teacher object.
p Teacher.ancestors
p GeographyTeacher.ancestors
p prof.printtheconsts #=> Both constants print.
p prof.gender #=> nil, the gender instance variable is uninitialzied but does not raise an error.
p prof.gender = "male" # => male, setter methods always return the value passed in.
p prof.gender #=> male
p prof #=> <GeographyTeacher:encoding of object id @name='Ralf', @age=22, @subject='Geography', @gender='male'> # The `p` method calls `inspect` on the object.
puts prof #=> <GeographyTeacher:encoding of object id> # The puts method calls `to_s` which returns class of the object and encoding of the object id, or as whatever a custom `to_s` method is defined to as this method is often overridden.

prof.addbook(geo101)

p prof
p teach

=end