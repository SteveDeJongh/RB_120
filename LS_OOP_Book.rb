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

  def self.total_number_of_dogs
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

  def info
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

=end