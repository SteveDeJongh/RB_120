#### RB120 Object Oritented Programming: Easy 1 ####

=begin
# 1) Banner Class # Worth revisiting FE.

# class Banner
#   attr_reader :width

#   def initialize(message)
#     @message = message
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end

#   private

#   def horizontal_rule
#     "+-#{"-"*(@message.size)}-+"
#   end

#   def empty_line
#     "| #{" " * (@message.size)} |"
#   end

#   def message_line
#     "| #{@message} |"
#   end
# end

# banner = Banner.new('To boldly go where no one has gone before.')
# puts banner
# # +--------------------------------------------+
# # |                                            |
# # | To boldly go where no one has gone before. |
# # |                                            |
# # +--------------------------------------------+

# banner = Banner.new('')
# puts banner
# # +--+
# # |  |
# # |  |
# # |  |
# # +--+

# FE

# class Banner
#   attr_reader :width

#   def initialize(message, width = message.size)
#     @message = message
#     @width = width
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end

#   private

#   def horizontal_rule
#     "+-#{"-"*(@width)}-+"
#   end

#   def empty_line
#     "| #{" " * (@width)} |"
#   end

#   def message_line
#     if @width < @message.size + 2
#       split_message
#     else
#       "| #{" " * ((@width - @message.size) / 2)}#{@message}#{" " * ((@width - @message.size) / 2)} |"
#     end    
#   end

#   def split_message
#     lines = []
#     working_line = ""
#     @message.chars.each do |char|
#       if working_line.length < @width
#         working_line += char
#       else
#         lines << working_line
#         working_line = char
#       end
#     end
#     lines << working_line

#     formatted_lines = []
#     lines.each_with_index do |msg, idx|
#       if idx != lines.size - 1
#         formatted_lines << "|#{msg.center(@width + 2)}|"
#       else
#         formatted_lines << "| #{msg + " " * (@width - msg.size)} |"
#       end
#     end
#     formatted_lines
#   end
# end

# banner = Banner.new('To boldly go where no one has gone before.', 30)
# puts banner
# # +-------------------------------+
# # |                               |
# # | To boldly go where no one has |
# # | gone before.                  |
# # |                               |
# # +-------------------------------+

# 2) What's the output?

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase! #upcase! mutates argument in place, affecting further calls to @name
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name #=> "Fluffy"
puts fluffy #=> "My name is FLUFFY."
puts fluffy.name #=> "FLUFFY"
puts name #=> "FLUFFY"

# Fix the class so that there are no suprises.

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name #=> "Fluffy"
puts fluffy #=> "My name is FLUFFY."
puts fluffy.name #=> "Fluffy"
puts name #=> "Fluffy"

# FE, What would hpapen in this case?

name = 42
fluffy = Pet.new(name) # @name is set to a new object created by name.to_s, link to outer scope variable name broken.
name += 1 # Only affects the global scope varialbe `name`
puts fluffy.name #=> "42" # return value of the call to reader method `:name`
puts fluffy #=> "My name is 42." # return of to_s method in `Pet`
puts fluffy.name #=> "42" # Return value of the call to reader method `:name`
puts name #=> "43" # Return of `puts` on global variable `name`

# The further exploration makes sense because, on line 1, we initialize name to the integer 42. Then on like 2, when we
# instantiate a new Pet object and pass in name the initialize instance method converts the integer 42 into a string "42"
# before assigning it to the instance variable @name. From that point, the two values are referencing different objects.
# Even if they weren't, integers are non-mutable, so line 2, would just be re-assigning the local variable name to a new
# integer 43 and wouldn't affect the object referenced by @name. From there, we're just outputing the string representations
# of the returns of each method call, with the exception of line 5, where we've overridden to_s with a custom method
# within the Pet class.

# 3) Fix the program - Books (Part 1)

class Book
  attr_reader :title, :author # Fix, add getter methods for @title and @author

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

#Expected output:
# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# 4) Fix the program - Books (Part 2)

class Book
  attr_accessor :author, :title # Need both getter and setter methods for :author and :title, so we use attr_accessor

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Expected output:
# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# 5) Fix the program - Persons
class Person
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def first_name=(name) # Add customer setter method to capitalize input.
    @first_name = name.capitalize
  end

  def last_name=(name) # Add customer setter method to capitalize input.
    @last_name = name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person

# Expected output:
# John Doe
# Jane Smith

# 6) Fix the program - Flight Data
class Flight
  attr_accessor :database_handle # Delete this line. Right now we can reassign this instance variable outside of initialization.

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# 7) Biggy Code - Car Mileage
class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total # `mileage = total` would be creating a new local `mileage` varialbe and no changing the instance variable @mileage
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678

# 8) Rectangles and Squares

class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
  def initialize(m)
    super(m, m)
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"

# 9) Complete the Program - Cats!

class Pet
  attr_reader :name, :age, :color

  def initialize(name, age, color)
    @name = name
    @age = age
    @color = color
  end
end

class Cat < Pet
  def to_s
    "My cat #{name} is #{age} years old and has #{color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# Expected output:
# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.

# 10) Refacotring Vehicles

class vehicle
  attr_reader :make, :model

  def initialize(make,model)
    @make = make
    @model = model
  end

  def to_s
    "#{@make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

=end