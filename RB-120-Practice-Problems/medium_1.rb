#### RB120 Object Oritented Programming: Medium 1 ####
require 'pry'
=begin

# 1) Privacy

# Consider the following class:

class Machine
  def initialize(switch)
    @switch = switch
  end

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def switch_position
    "My switch position is #{switch}."
  end

  private

  attr_reader :switch # FE
  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

# Modify this class so both flip_switch and the setter method switch= are private methods.

# FE Add a private getter for @switch to the Machine class, and add a method to Machine that shows how to use that getter.

m1 = Machine.new(:on)
p m1
p m1.switch_position
# p m1.switch # raises an error, `switch` it a private method.
m1.stop # Turns switch to :off.
p m1.switch_position

# 2) Fixed Array

# A fixed-length array is an array that always has a fixed number of elements. Write a class that implements
#  a fixed-length array, and provides the necessary methods to support the following code:

class FixedArray
  # attr_accessor :array

  def initialize(size) # initialize object with an array of `nil`s the size of `size`
    @array = [nil] * size # Or @array = Array.new(size)
  end

  def [](num) # Getter method
    @array.fetch(num) # Important to use fetch as element reference would return `nil` for out of bounds indexes.
  end

  def []=(index, value) # Setter method
    self[index] # raises an error if index is invalid.
    @array[index] = value
  end

  def to_a # output instance variable @array when called
    @array.clone # Returning a close of the array so that any changes don't affect the instance variable.
  end

  def to_s # Output the instance variable @array as a string when called.
    to_a.to_s
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end

# 3) Students

# Below we have 3 classes: Student, Graduate, and Undergraduate. The implementation details for
# the #initialize methods in Graduate and Undergraduate are missing. Fill in those missing details
# so that the following requirements are fulfilled:

# Graduate students have the option to use on-campus parking, while Undergraduate students do not.

# Graduate and Undergraduate students both have a name and year associated with them.

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end

# FE highlights how `Super()` can be used.

=end

# 4) Circular Queue

class CircularQueue
  def initialize(size)
    @buffer = Array.new(size)
    @next_position = 0
    @oldest_position = 0
  end

  def enqueue(obj) # To add an object to the queue
    unless @buffer[@next_position].nil?
      @oldest_position = increment(@next_position)
    end

    @buffer[@next_position] = obj
    @next_position = increment(@next_position)
  end

  def dequeue # To remove an object from the queue
    value = @buffer[@oldest_position]
    @buffer[@oldest_position] = nil
    @oldest_position = increment(@oldest_position) unless value.nil?
    value
  end

  private

  def increment(position) # Method used to "Wrap around" back to index 0.
    (position + 1) % @buffer.size
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)

puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil