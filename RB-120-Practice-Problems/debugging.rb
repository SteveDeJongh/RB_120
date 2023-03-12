#### RB120 Object Oritented Programming: Debugging ####
require 'pry'
=begin
# 1) Community Library

# On line 54 of our code, we intend to display information regarding the books currently checked in to our
#  community library. Instead, an exception is raised. Determine what caused this error and fix the code so
#   that the data is displayed as expected.

class Library
  attr_accessor :address, :phone, :books

  def initialize(address, phone)
    @address = address
    @phone = phone
    @books = []
  end

  def check_in(book)
    books.push(book)
  end

  #new method
  def display_books
    books.each do |book|
      book.display_data
    end
  end

end

class Book
  attr_accessor :title, :author, :isbn

  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end

  def display_data
    puts "---------------"
    puts "Title: #{title}"
    puts "Author: #{author}"
    puts "ISBN: #{isbn}"
    puts "---------------"
  end
end

community_library = Library.new('123 Main St.', '555-232-5652')
learn_to_program = Book.new('Learn to Program', 'Chris Pine', '978-1934356364')
little_women = Book.new('Little Women', 'Louisa May Alcott', '978-1420951080')
wrinkle_in_time = Book.new('A Wrinkle in Time', 'Madeleine L\'Engle', '978-0312367541')

community_library.check_in(learn_to_program)
community_library.check_in(little_women)
community_library.check_in(wrinkle_in_time)
binding.pry
community_library.display_books

# We are calling a `display_data` method for a single book object rather than the books array. Raising an error.
# To fix this, we can create a new method in `Library` and use the display_data method, called on the Library object.

# If we didn't want to implement a new metho in Library, we could do:
# community_library.books.each do |book|
#   book.display_data
# end

# 2) Animal Kingdom

# The code below raises an exception. Examine the error message and alter the code so that it runs without error.

class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower) # This method definition is not required as it is defined the same as the superclass intialize.
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    super(diet, superpower) # add the desired passed arguments, as by default all are passed.
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')

# The error raised is a `ArgumentError` for passing too many arguments to line 78.

# This error is raised as by default, all arguments are passed to calls of `super`. The initialize method in `SongBird` which sub-classes
# `Bird`, takes 3 arguments. As we want to use one argument locally, and only pass the 2 required for the `Bird` intialize method,
# we need to specifiy the arguments passed to `super.`

# Further Exploration.

# No the FlightlessBird `initialize` method is not neccessary. The method is defined in the same manner as the supper class.

# 3)Wish You Were Here

# On lines 178 and 179 of our code, we can see that grace and ada are located at the same coordinates. 
# So why does line 180 output false? Fix the code to produce the expected output.

class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def ==(other) # Method required to compared Geolocation objects as per their lat & long rather than object_id's.
    lattitude == other.lattitude && longitude == other.longitude

  def to_s
    "(#{latitude}, #{longitude})"
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false

# This is because we are comparing different Geolocation objects, and not the content of the object itself.

# On line 180 of our original code, we invoke the == method to compare the equality of two locations. Since our
#  GeoLocation class does not implement ==, Ruby invokes the method from the BasicObject class. BasicObject#==,
#   however, returns true only if the two objects being compared are the same object, or in other words, if they
#    have the same object id.

# In order to compare the equality of our Geolocation objects according to their lattitude and longitude, we need
# to define a `==` method in the GeoLocation class. Thanks to Ruby's method lookup path, this method will override
# BasicObject#== method.

# 4)Employee Management

# We have written some code for a simple employee management system. Each employee must have a unique serial
# number. However, when we are testing our program, an exception is raised. Fix the code so that the program
# works as expected without error.

class EmployeeManagementSystem
  attr_reader :employer

  def initialize(employer)
    @employer = employer
    @employees = []
  end

  def add(employee)
    if exists?(employee)
      puts "Employee serial number is already in the system."
    else
      employees.push(employee)
      puts "Employee added."
    end
  end

  alias_method :<<, :add

  def remove(employee)
    if !exists?(employee)
      puts "Employee serial number is not in the system."
    else
      employees.delete(employee)
      puts "Employee deleted."
    end
  end

  def exists?(employee)
    employees.any? { |e| e == employee }
  end

  def display_all_employees
    puts "#{employer} Employees: "

    employees.each do |employee|
      puts ""
      puts employee.to_s
    end
  end

  private

  attr_accessor :employees
end

class Employee
  attr_reader :name

  def initialize(name, serial_number)
    @name = name
    @serial_number = serial_number
  end

  def ==(other)
    serial_number == other.serial_number
  end

  def to_s
    "Name: #{name}\n" +
    "Serial No: #{abbreviated_serial_number}"
  end

  protected

  attr_reader :serial_number

  private

  def abbreviated_serial_number
    serial_number[-4..-1]
  end
end

# Example

miller_contracting = EmployeeManagementSystem.new('Miller Contracting')

becca = Employee.new('Becca', '232-4437-1932')
raul = Employee.new('Raul', '399-1007-4242')
natasha = Employee.new('Natasha', '399-1007-4242')

miller_contracting << becca     # => Employee added.
miller_contracting << raul      # => Employee added.
miller_contracting << raul      # => Employee serial number is already in the system.
miller_contracting << natasha   # => Employee serial number is already in the system.
miller_contracting.remove(raul) # => Employee deleted.
miller_contracting.add(natasha) # => Employee added.

miller_contracting.display_all_employees

# The exception raised is `NoMethodError` for a private method for `serial_number` called on an Employee object.

# Private method can only be invoked on `self`. But on line 259, in `Employee#==` we attempt to invoke `serial_number` on 
# an object that is not the current instance (other).

# In order to make this work, we can make `serial_number` a protected method. Recall that from otuside the class, protected methods
# work just like private methods. From inside the class, however, protected methods are accessible an may be invoked with an explicit
# caller.

# 5)Files
# You started writing a very basic class for handling files. However, when you begin to write some simple test code,
#  you get a NameError. The error message complains of an uninitialized constant File::FORMAT.

# What is the problem and what are possible ways to fix it?

class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{self.class::FORMAT}" # Instead of "#{name}.#{FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post

# The error occurs when we use the File#to_s method. The reason is our use of the constant FORMAT.
# When Ruby resolves a constant, it looks it up in its lexical scope, in this case in the File class
# as well as in all of its ancestor classes. Since it doesn't find it in any of them, it throws a NameError.

# There are several ways to fix this. For example, instead of defining to_s in the File class, we 
# could define it in each of the subclasses, in which the FORMAT constant is defined. But this would
# duplicate the exact same method, so the DRY principle advises us against it.

# Alternatively, we can add explicit namespacing, as we do in our solution, by prepending the class 
# name. Which class? This will be determined by the subclass from which we are calling to_s. We can
# reference this subclass as self.class - the class of the caller of the method (blog_post in our
# example). Using self.class offers the same flexibility that we use on line 12 when creating a 
# new instance of the subclass from which we are calling new.

=end

# 6) 