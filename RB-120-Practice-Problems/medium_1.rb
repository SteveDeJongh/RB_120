#### RB120 Object Oritented Programming: Medium 1 ####

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


=end

# 2) Fixed Array

# A fixed-length array is an array that always has a fixed number of elements. Write a class that implements
#  a fixed-length array, and provides the necessary methods to support the following code:

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