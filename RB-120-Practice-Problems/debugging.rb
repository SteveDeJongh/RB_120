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

# 6) Sorting Distances

# When attempting to sort an array of various lengths, we are surprised to see that an ArgumentError
# is raised. Make the necessary changes to our code so that the various lengths can be properly sorted
# and line 435 produces the expected output.

class Length
  attr_reader :value, :unit

  def initialize(value, unit)
    @value = value
    @unit = unit
  end

  def as_kilometers
    convert_to(:km, { km: 1, mi: 0.6213711, nmi: 0.539957 })
  end

  def as_miles
    convert_to(:mi, { km: 1.609344, mi: 1, nmi: 0.8689762419 })
  end

  def as_nautical_miles
    convert_to(:nmi, { km: 1.8519993, mi: 1.15078, nmi: 1 })
  end

  def <=>(other) # The object must have a `<=>` to sort.
    case unit
    when :km  then value <=> other.as_kilometers.value
    when :mi  then value <=> other.as_miles.value
    when :nmi then value <=> other.as_nautical_miles.value
    end
  end
  
  # The below == < <= > >= methods can be remove, and the `comparable` module may be added instead as it implements
  # all of the comparision using the <=> instead.
  def ==(other)
    case unit
    when :km  then value == other.as_kilometers.value
    when :mi  then value == other.as_miles.value
    when :nmi then value == other.as_nautical_miles.value
    end
  end

  def <(other)
    case unit
    when :km  then value < other.as_kilometers.value
    when :mi  then value < other.as_miles.value
    when :nmi then value < other.as_nautical_miles.value
    end
  end

  def <=(other)
    self < other || self == other
  end

  def >(other)
    !(self <= other)
  end

  def >=(other)
    self > other || self == other
  end

  def to_s
    "#{value} #{unit}"
  end

  private

  def convert_to(target_unit, conversion_factors)
    Length.new((value / conversion_factors[unit]).round(4), target_unit)
  end
end

# Example

puts [Length.new(1, :mi), Length.new(1, :nmi), Length.new(1, :km)].sort
# => comparison of Length with Length failed (ArgumentError)
# expected output:
# 1 km
# 1 mi
# 1 nmi

# 7) Bank Balance

# We created a simple BankAccount class with overdraft protection, that does not allow a withdrawal
# greater than the amount of the current balance. We wrote some example code to test our program. 
# However, we are surprised by what we see when we test its behavior. Why are we seeing this unexpected
# output? Make changes to the code so that we see the appropriate behavior.

class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount > 0 && valid_transaction?(balance - amount)
      self.balance -= amount
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  # above instead of:
  # def withdraw(amount)
  #   if amount > 0
  #     success = (self.balance -= amount)
  #   else
  #     success = false
  #   end

  #   if success
  #     "$#{amount} withdrawn. Total balance is $#{balance}."
  #   else
  #     "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
  #   end
  # end

  def balance=(new_balance)
    @balance = new_balance
  end

  # Above instead of :
  # def balance=(new_balance) # Setter method! Always returns argument that was passed in.
  #   if valid_transaction?(new_balance)
  #     @balance = new_balance
  #     true
  #   else
  #     false
  #   end
  # end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
                          # Actual output: $80 withdrawn. Total balance is $50.
p account.balance         # => 50

# Further Exploration

If you mutate the argument of a setter method, the return value of the setter method is returned.

class Actor
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def name=(new_name)
    @name = new_name.upcase!
  end
end

brad = Actor.new('Brad Pitt')
result = (brad.name = 'Leonardo di Caprio')

puts result     # => LEONARDO DI CAPRIO
puts brad.name  # => LEONARDO DI CAPRIO


# 8) Task Manager

# Valentina is using a new task manager program she wrote. When interacting with her task manager,
#  an error is raised that surprises her. Can you find the bug and fix it?

class TaskManager
  attr_reader :owner
  attr_accessor :tasks

  def initialize(owner)
    @owner = owner
    @tasks = []
  end

  def add_task(name, priority=:normal)
    task = Task.new(name, priority)
    tasks.push(task)
  end

  def complete_task(task_name)
    completed_task = nil

    tasks.each do |task|
      completed_task = task if task.name == task_name
    end

    if completed_task
      tasks.delete(completed_task)
      puts "Task '#{completed_task.name}' complete! Removed from list."
    else
      puts "Task not found."
    end
  end

  def display_all_tasks
    display(tasks)
  end

  def display_high_priority_tasks
    tasks = tasks.select do |task|
      task.priority == :high
    end

    display(tasks)
  end

  def display_high_priority_tasks
    high_prio_tasks = tasks.select do |task|
      task.priority == :high
    end

    display(high_prio_tasks)
  end

  # def display_high_priority_tasks
  #   tasks = tasks.select do |task| # `tasks.select`, the getter method for @tasks is hidden by the new local variable
  #                                  # `tasks` on the left side of the `=`. 
  #     task.priority == :high
  #   end

  #   display(tasks)
  # end

  private

  def display(tasks)
    puts "--------"
    tasks.each do |task|
      puts task
    end
    puts "--------"
  end
end

class Task
  attr_accessor :name, :priority

  def initialize(name, priority=:normal)
    @name = name
    @priority = priority
  end

  def to_s
    "[" + sprintf("%-6s", priority) + "] #{name}"
  end
end

valentinas_tasks = TaskManager.new('Valentina')

valentinas_tasks.add_task('pay bills', :high)
valentinas_tasks.add_task('read OOP book')
valentinas_tasks.add_task('practice Ruby')
valentinas_tasks.add_task('run 5k', :low)

valentinas_tasks.complete_task('read OOP book')

valentinas_tasks.display_all_tasks
valentinas_tasks.display_high_priority_tasks

# 9) You've Got Mail!

# Can you decipher and fix the error that the following code produces?

class Mail
  def to_s
    "#{self.class}"
  end
end

class Email < Mail
  attr_accessor :subject, :body

  def initialize(subject, body)
    @subject = subject
    @body = body
  end
end

class Postcard < Mail
  attr_reader :text

  def initialize(text)
    @text = text
  end
end

module Mailing
  def receive(mail, sender)
    mailbox << mail unless reject?(sender)
  end

  # Change if there are sources you want to block.
  def reject?(sender)
    false
  end

  def send_mail(destination, mail) # Change method name from `send` to `send_mail` to avoid accidental method overiding of Object#send.
    "Sending #{mail} from #{name} to: #{destination}"
    # Omitting the actual sending.
  end
end

class CommunicationsProvider
  attr_reader :name, :account_number

  def initialize(name, account_number=nil)
    @name = name
    @account_number = account_number
  end
end

class EmailService < CommunicationsProvider
  include Mailing

  attr_accessor :email_address, :mailbox

  def initialize(name, account_number, email_address)
    super(name, account_number)
    @email_address = email_address
    @mailbox = []
  end

  def empty_inbox
    self.mailbox = []
  end
end

class TelephoneService < CommunicationsProvider
  def initialize(name, account_number, phone_number)
    super(name, account_number)
    @phone_number = phone_number
  end
end

class PostalService < CommunicationsProvider
  include Mailing

  attr_accessor :street_address, :mailbox

  def initialize(name, street_address)
    super(name)
    @street_address = street_address
    @mailbox = []
  end

  def change_address(new_address)
    self.street_address = new_address
  end
end

rafaels_email_account = EmailService.new('Rafael', 111, 'Rafael@example.com')
johns_phone_service   = TelephoneService.new('John', 122, '555-232-1121')
johns_postal_service  = PostalService.new('John', '47 Sunshine Ave.')
ellens_postal_service = PostalService.new('Ellen', '860 Blackbird Ln.')

puts johns_postal_service.send_mail(ellens_postal_service.street_address, Postcard.new('Greetings from Silicon Valley!'))
# => undefined method `860 Blackbird Ln.' for #<PostalService:0x00005571b4aaebe8> (NoMethodError)

 10) Does it Rock or Not?

# We discovered Gary Bernhardt's repository for finding out whether something rocks or not, and
#  decided to adapt it for a simple example.

class AuthenticationError < StandardError; end # Avoid inheriting from `Exception`

# A mock search engine
# that returns a random number instead of an actual count.
class SearchEngine
  def self.count(query, api_key)
    unless valid?(api_key)
      raise AuthenticationError, 'API key is not valid.'
    end

    rand(200_000)
  end

  private

  def self.valid?(key)
    key == 'LS1A'
  end
end

module DoesItRock
  API_KEY = 'LS1A'

  class NoScore; end

  class Score
    def self.for_term(term)
      positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
      negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

      positive / (positive + negative)
    rescue ZeroDivisionError # Changed from Exception
      NoScore.new # Must return an instance of NoScore to use in case `===` comparison.
    end
  end

  def self.find_out(term)
    score = Score.for_term(term)

    case score
    when NoScore # Checks if score is an instance of the NoScore class.
      "No idea about #{term}..."
    when 0...0.5
      "#{term} is not fun."
    when 0.5
      "#{term} seems to be ok..."
    else
      "#{term} rocks!"
    end
  rescue StandardError => e # changed from Exception
    e.message
  end
end

# Example (your output may differ)

puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
puts DoesItRock.find_out('Rain')        # Rain is not fun.
puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!

# In order to test the case when authentication fails, we can simply set API_KEY to any string other
#  than the correct key. Now, when using a wrong API key, we want our mock search engine to raise an 
#  AuthenticationError, and we want the find_out method to catch this error and print its error message
#   API key is not valid.

# Is this what you expect to happen given the code?
  
# And why do we always get the following output instead?
  
  # Copy Code
  # Sushi rocks!
  # Rain rocks!
  # Bug hunting rocks!

Discussion
The SearchEngine indeed raises an AuthenticationError, but it never reaches the DoesItRock::find_out method,
 because Score::for_term already catches it, resulting in the return value NoScore.

But if the return value is NoScore, why does the find_out method not print the message
 "No idea about #{term}..."? In order to see this, recall how case statements work. The value of score will
   be compared with each value in the when clauses using the === operator. In case of the first when clause,
     the comparison is NoScore === score, and since the left-hand side is a class, its implementation boils 
     down to checking whether score is_a? NoScore. This yields false when score has the value NoScore, as it 
     is not an instance of the NoScore class. As a result, we end up with the value of the else clause.

In order to fix this, Score::for_term has to return an instance of the NoScore class (i.e. NoScore.new), instead
 of the name of the class itself.

Now, back to the original problem: if the API key is wrong, we want the AuthenticationError to reach the find_out
 method. One way to achieve this is to simply remove the rescue clause in Score::for_term. But this would also
  prevent us from rescuing other exceptions, like a possible ZeroDivisionError, which arguably is a perfect
   occasion to return no score. In order to solve this, we decide to rescue only that specific exception within
    Score::for_term and let all others through.

With those changes, the code runs as expected. However, there is still one thing wrong about our code, which is
 less obvious. And that's the use of Exception.

Exception is the top-most class in Ruby's exception hierarchy and it seems a straightforward choice to rescue
 or inherit from. But it's too broad. When creating custom exceptions and when rescuing exceptions, it's good
  practice to always use the subclass StandardError. StandardError subsumes all application-level errors. The 
  other descendants of Exception are used for system- or environment-level errors, like memory overflows or 
  program interruptions. These are the kind of errors your application usually does not want to throw - and 
  definitely does not want to rescue, they should be handled by Ruby itself.

=end