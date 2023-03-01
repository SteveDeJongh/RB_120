=begin

############# RB 120 - LS Object Oriented Programming Book ########

Practice Questions

1) How do we create an object in Ruby? Give an example of the creation of an object.

class Person
end

first_person = Person.new

p first_person.class #=> "Person"

2) What is a module? What is its purpose? How do we use them with our classes? Create a module
   for the class you created in exercise 1 and include it properly.
  
module Swimmable
end

class Person
  include Swimmable
end

first_person = Person.new

# Setter and getter class methods

class GoodDog
  def initialize(name)
    @name = name
  end

  def name # 'Getter' method
    @name
  end

  def name=(n) # 'Setter' method
    @name = n
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new('Sparky')

puts sparky.speak
puts sparky.name
sparky.name = "Spartacus" # Ruby's synatax recognizing that `set_name=` is a `setter` method
puts sparky.name

# Refactored using attr_accessor

class GoodDog

  attr_accessor :name
  
  def initialize(name)
    @name = name
  end

  def speak
    "#{name} says arf!" # Now using the accessor method `name` to retrive the instance variables name
  end
end

sparky = GoodDog.new('Sparky')

puts sparky.speak
puts sparky.name
sparky.name = "Spartacus" # Ruby's synatax recognizing that `set_name=` is a `setter` method
puts sparky.name

# Using `self` to diambiguate from variable assignemnt in instance method `change_info`

class GoodDog

  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{@name} says arf!"
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

sparky = GoodDog.new('Sparky', "12 inches", "10 lbs")

puts sparky.info
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info

# Exercises:
1) Create a class called MyCar. When you initialize a new instance or object of the class, 
allow the user to define some instance variables that tell us the year, color, and model of the 
car. Create an instance variable that is set to 0 during instantiation of the object to track the 
current speed of the car as well. Create instance methods that allow the car to speed up, brake, 
and shut the car off.

class MyCar
  def initialize(y, c, m)
    @year = y
    @colour = c
    @model = m
    @speed = 0
  end

  def speed_up(num)
   @speed += num
   puts "You sped up to #{@speed} kph"
  end

  def brake(num)
    @speed -= num
    puts "You braked down to #{@speed} kph"
  end

  def current_speed
    puts "You are now going #{@speed} kph"
  end

  def turn_off()
    @speed = 0
    puts "You turned off the car, speed is now #{@speed} kph"
  end

end

vroom = MyCar.new(2001, "Red", "Mazda")

vroom.speed_up(20)
vroom.current_speed
vroom.brake(5)
vroom.turn_off

2) Add an accessor method to your MyCar class to change and view the color of your car. 
Then add an accessor method that allows you to view, but not modify, the year of your car.

class MyCar
  attr_accessor :colour # Setter and getter methods
  attr_reader :year # getter method

  def initialize(y, c, m)
    @year = y
    @colour = c
    @model = m
    @speed = 0
  end

  def speed_up(num)
   @speed += num
   puts "You sped up to #{@speed} kph"
  end

  def brake(num)
    @speed -= num
    puts "You braked down to #{@speed} kph"
  end

  def current_speed
    puts "You are now going #{@speed} kph"
  end

  def turn_off()
    @speed = 0
    puts "You turned off the car, speed is now #{@speed} kph"
  end
end

vroom = MyCar.new(2001, "Red", "Mazda")

p vroom.colour
vroom.colour = "Blue"
p vroom.colour
p vroom.year

3) You want to create a nice interface that allows you to accurately describe the action you
 want your program to perform. Create a method called spray_paint that can be called on an object
  and will modify the color of the car.

class MyCar
  attr_accessor :color # Setter and getter methods
  attr_reader :year # getter method

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def speed_up(num)
   @speed += num
   puts "You sped up to #{@speed} kph"
  end

  def brake(num)
    @speed -= num
    puts "You braked down to #{@speed} kph"
  end

  def current_speed
    puts "You are now going #{@speed} kph"
  end

  def turn_off()
    @speed = 0
    puts "You turned off the car, speed is now #{@speed} kph"
  end

  def spray_paint(col)
    self.color = col #self.color uses the setter method on :colour from `attr_accessor`. Alternatively, it could just be `@color = col`
    puts "Your new #{color} paint job looks great!"
  end
end

vroom = MyCar.new(2001, "Red", "Mazda")

p vroom.color
vroom.color = "Blue"
p vroom.color
vroom.spray_paint("Red")
p vroom.color

#### Class Methods

class GoodDog
  def self.what_am_i
    "I'm a GoodDog class!"
  end
end

p GoodDog.what_am_i #=> "I'm a GoodDog class!"

### Class variables

class GoodDog
  @@number_of_dogs = 0 # Class variable

  def initialize # Constructor
    @@number_of_dogs += 1 # incrementing class variable upon instantiation of an new class object.
  end

  def self.total_number_of_dogs # Class method
    @@number_of_dogs @ # returning class variable
  end
end

puts GoodDog.total_number_of_dogs

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs

## Constants

class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky.age             # => 28

#### More about self

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def info # Instance method
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end

  puts self # `self` references the class itself

  def self.this_is_a_class_method # class method 
    puts "Class method!"
  end

end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self # `self` references the calling object `sparky`
GoodDog.this_is_a_class_method # Calling the class method.

###### Exercises ######
1) Add a class method to your MyCar class that calculates the gas mileage of any car.

class MyCar
  attr_accessor :color # Setter and getter methods
  attr_reader :year # getter method
  
  def self.gas_mileage(gallons, miles) # calling self insinuates its a class method.
    puts "#{miles/gallons} miles per gallon of gas"
  end

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def speed_up(num)
   @speed += num
   puts "You sped up to #{@speed} kph"
  end

  def brake(num)
    @speed -= num
    puts "You braked down to #{@speed} kph"
  end

  def current_speed
    puts "You are now going #{@speed} kph"
  end

  def turn_off()
    @speed = 0
    puts "You turned off the car, speed is now #{@speed} kph"
  end

  def spray_paint(col)
    self.color = col #self.color uses the setter method on :colour from `attr_accessor`. Alternatively, it could just be `@color = col`
    puts "Your new #{color} paint job looks great!"
  end
end

MyCar.gas_mileage(13, 351) #=> "27 miles per gallon of gas"

2) Override the to_s method to create a user friendly print out of your object.

class MyCar
  attr_accessor :color # Setter and getter methods
  attr_reader :year # getter method
  attr_reader :model # getter method
  
  def self.gas_mileage(gallons, miles) # calling self insinuates its a class method.
    puts "#{miles/gallons} miles per gallon of gas"
  end

  def to_s # Overrides "to_s" on puts ... call.
    "My car is a #{year}, #{color}, #{model}" # using attr methods to retrieve instance variables.
  end

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def speed_up(num)
   @speed += num
   puts "You sped up to #{@speed} kph"
  end

  def brake(num)
    @speed -= num
    puts "You braked down to #{@speed} kph"
  end

  def current_speed
    puts "You are now going #{@speed} kph"
  end

  def turn_off()
    @speed = 0
    puts "You turned off the car, speed is now #{@speed} kph"
  end

  def spray_paint(col)
    self.color = col #self.color uses the setter method on :colour from `attr_accessor`. Alternatively, it could just be `@color = col`
    puts "Your new #{color} paint job looks great!"
  end
end

Toyota = MyCar.new(2017, "Red", "Tacoma")

puts Toyota # call to instance methof `to_s` => "My car is a 2017, Red, Tacoma"

3) When running the following code:
class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

We get the folowing error:
test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

Why do we get this error and how do we fix it?

We get this error due to there not being a setter method for the instance variables `name`.
We can add, `attr_writter :name`, or change the attr_reader to `attr_accessor`

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

#### Class Inheritance

class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal # GoodDog inherits the `Animal` class. GoodDog is the subclass, `Animal` the superclass
end

class Cat < Animal
end

sparky = GoodDog.new
paws = Cat.new
puts sparky.speak           # => Hello!
puts paws.speak             # => Hello!

############## Exercises #############

1) Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior that
 isn't specific to the MyCar class to the superclass. Create a constant in your MyCar class that stores
  information about the vehicle that makes it different from other types of Vehicles.

Then create a new class called MyTruck that inherits from your superclass that also has a constant
 defined that separates it from the MyCar class in some way.

class Vehicle
  attr_accessor :color # Setter and getter methods
  attr_reader :year # getter method
  attr_reader :model # getter method
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def self.gas_mileage(gallons, miles) # calling self insinuates its a class method.
    puts "#{miles/gallons} miles per gallon of gas"
  end

  def speed_up(num)
   @speed += num
   puts "You sped up to #{@speed} kph"
  end

  def brake(num)
    @speed -= num
    puts "You braked down to #{@speed} kph"
  end

  def current_speed
    puts "You are now going #{@speed} kph"
  end

  def turn_off()
    @speed = 0
    puts "You turned off the car, speed is now #{@speed} kph"
  end

  def spray_paint(col)
    self.color = col #self.color uses the setter method on :colour from `attr_accessor`. Alternatively, it could just be `@color = col`
    puts "Your new #{color} paint job looks great!"
  end
end

class MyCar < Vehicle # MyCar inherits from superclass `Vehicle`
  NUMBER_OF_DOORS = 4

  def to_s # Overrides "to_s" on puts... call.
    "My car is a #{year}, #{color}, #{model}" # using attr methods to retrieve instance variables.
  end
end

class MyTruck < Vehicle # MyTruck also inherits from superclass `Vehicle`
  NUMBER_OF_DOORS = 2

  def to_s # Overrides "to_s" on puts... call.
    "My truck is a #{year}, #{color}, #{model}" # using attr methods to retrieve instance variables.
  end
end

Subaru = MyCar.new(2021, "Blue", "Subaru Crosstrek")
Toyota = MyTruck.new(2017, "Red", "Tacoma")

puts Toyota
puts Subaru

2) Add a class variable to your superclass that can keep track of the number of objects created that inherit from the
 superclass. Create a method to print out the value of this class variable as well.

class Vehicle
  attr_accessor :color # Setter and getter methods
  attr_reader :year # getter method
  attr_reader :model # getter method

  @@number_of_vehicles = 0 # Class variable

  def self.number_of_vehicles # Class method
    puts "This program has created #{@@number_of_vehicles} vehicles."
  end
  
  def initialize(y, c, m)
    @@number_of_vehicles += 1
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def self.gas_mileage(gallons, miles) # calling self insinuates its a class method.
    puts "#{miles/gallons} miles per gallon of gas"
  end

  def speed_up(num)
   @speed += num
   puts "You sped up to #{@speed} kph"
  end

  def brake(num)
    @speed -= num
    puts "You braked down to #{@speed} kph"
  end

  def current_speed
    puts "You are now going #{@speed} kph"
  end

  def turn_off()
    @speed = 0
    puts "You turned off the car, speed is now #{@speed} kph"
  end

  def spray_paint(col)
    self.color = col #self.color uses the setter method on :colour from `attr_accessor`. Alternatively, it could just be `@color = col`
    puts "Your new #{color} paint job looks great!"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s # Overrides "to_s" on puts... call.
    "My car is a #{year}, #{color}, #{model}" # using attr methods to retrieve instance variables.
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2

  def to_s # Overrides "to_s" on puts... call.
    "My truck is a #{year}, #{color}, #{model}" # using attr methods to retrieve instance variables.
  end
end

Subaru = MyCar.new(2021, "Blue", "Subaru Crosstrek")
Toyota = MyTruck.new(2017, "Red", "Tacoma")

puts Vehicle.number_of_vehicles

3) Create a module that you can mix in to ONE of your subclasses that describes a behavior unique to that subclass.

class Vehicle
  attr_accessor :color # Setter and getter methods
  attr_reader :year # getter method
  attr_reader :model # getter method

  @@number_of_vehicles = 0 # Class variable

  def self.number_of_vehicles # Class method
    puts "This program has created #{@@number_of_vehicles} vehicles."
  end
  
  def initialize(y, c, m)
    @@number_of_vehicles += 1
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def self.gas_mileage(gallons, miles) # calling self insinuates its a class method.
    puts "#{miles/gallons} miles per gallon of gas"
  end

  def speed_up(num)
   @speed += num
   puts "You sped up to #{@speed} kph"
  end

  def brake(num)
    @speed -= num
    puts "You braked down to #{@speed} kph"
  end

  def current_speed
    puts "You are now going #{@speed} kph"
  end

  def turn_off()
    @speed = 0
    puts "You turned off the car, speed is now #{@speed} kph"
  end

  def spray_paint(col)
    self.color = col #self.color uses the setter method on :colour from `attr_accessor`. Alternatively, it could just be `@color = col`
    puts "Your new #{color} paint job looks great!"
  end
end

module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s # Overrides "to_s" on puts... call.
    "My car is a #{year}, #{color}, #{model}" # using attr methods to retrieve instance variables.
  end
end

class MyTruck < Vehicle
  include Towable
  NUMBER_OF_DOORS = 2

  def to_s # Overrides "to_s" on puts... call.
    "My truck is a #{year}, #{color}, #{model}" # using attr methods to retrieve instance variables.
  end
end

Subaru = MyCar.new(2021, "Blue", "Subaru Crosstrek")
Toyota = MyTruck.new(2017, "Red", "Tacoma")

# puts Subaru.can_tow?(300) # Undefined method for MyCar object class
puts Toyota.can_tow?(300) # Returns true, `can_tow?` included in MyTruck class and evaluates to true.

4) Print to the screen your method lookup for the classes that you have created.

puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors

5) Move all of the methods from the MyCar class that also pertain to the MyTruck class into the Vehicle class. Make sure that
 all of your previous method calls are working when you are finished.

class Vehicle
  attr_accessor :color # Setter and getter methods
  attr_reader :year # getter method
  attr_reader :model # getter method

  @@number_of_vehicles = 0 # Class variable

  def self.number_of_vehicles # Class method
    puts "This program has created #{@@number_of_vehicles} vehicles."
  end
  
  def initialize(y, c, m)
    @@number_of_vehicles += 1
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def self.gas_mileage(gallons, miles) # calling self insinuates its a class method.
    puts "#{miles/gallons} miles per gallon of gas"
  end

  def speed_up(num)
   @speed += num
   puts "You sped up to #{@speed} kph"
  end

  def brake(num)
    @speed -= num
    puts "You braked down to #{@speed} kph"
  end

  def current_speed
    puts "You are now going #{@speed} kph"
  end

  def turn_off()
    @speed = 0
    puts "You turned off the car, speed is now #{@speed} kph"
  end

  def spray_paint(col)
    self.color = col #self.color uses the setter method on :colour from `attr_accessor`. Alternatively, it could just be `@color = col`
    puts "Your new #{color} paint job looks great!"
  end
end

module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s # Overrides "to_s" on puts... call.
    "My car is a #{year}, #{color}, #{model}" # using attr methods to retrieve instance variables.
  end
end

class MyTruck < Vehicle
  include Towable
  NUMBER_OF_DOORS = 2

  def to_s # Overrides "to_s" on puts... call.
    "My truck is a #{year}, #{color}, #{model}" # using attr methods to retrieve instance variables.
  end
end

Subaru = MyCar.new(2021, "Blue", "Subaru Crosstrek")
Toyota = MyTruck.new(2017, "Red", "Tacoma")

puts Subaru.speed_up(20)
puts Toyota.spray_paint("blue")
puts Toyota
puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors

6) Write a method called age that calls a private method to calculate the age of the vehicle. Make sure the 
private method is not available from outside of the class. You'll need to use Ruby's built-in Time class to help.

class Vehicle
  attr_accessor :color # Setter and getter methods
  attr_reader :year # getter method
  attr_reader :model # getter method

  @@number_of_vehicles = 0 # Class variable

  def age
    puts "Your #{model} is #{years_old} years old."
  end

  def self.number_of_vehicles # Class method
    puts "This program has created #{@@number_of_vehicles} vehicles."
  end
  
  def initialize(y, c, m)
    @@number_of_vehicles += 1
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def self.gas_mileage(gallons, miles) # calling self insinuates its a class method.
    puts "#{miles/gallons} miles per gallon of gas"
  end

  def speed_up(num)
   @speed += num
   puts "You sped up to #{@speed} kph"
  end

  def brake(num)
    @speed -= num
    puts "You braked down to #{@speed} kph"
  end

  def current_speed
    puts "You are now going #{@speed} kph"
  end

  def turn_off()
    @speed = 0
    puts "You turned off the car, speed is now #{@speed} kph"
  end

  def spray_paint(col)
    self.color = col #self.color uses the setter method on :colour from `attr_accessor`. Alternatively, it could just be `@color = col`
    puts "Your new #{color} paint job looks great!"
  end

  private

  def years_old
    t = Time.now.year
    years_old = t - year.to_i # If year is initiailized as a string.
  end
end

module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s # Overrides "to_s" on puts... call.
    "My car is a #{year}, #{color}, #{model}" # using attr methods to retrieve instance variables.
  end
end

class MyTruck < Vehicle
  include Towable
  NUMBER_OF_DOORS = 2

  def to_s # Overrides "to_s" on puts... call.
    "My truck is a #{year}, #{color}, #{model}" # using attr methods to retrieve instance variables.
  end
end

Subaru = MyCar.new(2021, "Blue", "Subaru Crosstrek")
Toyota = MyTruck.new(2017, "Red", "Tacoma")

puts Subaru.age

7) Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will
 raise an error. Create a better_grade_than? method, that you can call like so...

class Student
  attr_accessor :name

  def initialize(n, g)
    @name = n
    @grade = g
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected
  
  attr_reader :grade

end

joe = Student.new("joe", 80)
bob = Student.new("bob", 70)

puts "Well done!" if joe.better_grade_than?(bob)

8) Given the following code...
bob = Person.new
bob.hi
And the corresponding error message...
NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
from (irb):8
from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

What is the problem and how would you go about fixing it?

The `hi` method called is a private method and therefor unavailable to the object. I would fix this by moving the `hi`
method above the `private` method call in the class.

=end