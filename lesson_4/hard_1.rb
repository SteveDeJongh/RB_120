################################## RB 120 Lesson 4 ########################################

# Practice Problems: Hard 1
=begin

# Question 1)
# Ben and Alyssa are working on a vehicle management system. So far, they have created classes called Auto and
# Motorcycle to represent automobiles and motorcycles. After having noticed common information and calculations
# they were performing for each type of vehicle, they decided to break out the commonality into a separate
# class called WheeledVehicle. This is what their code looks like so far:

class WheeledVehicle
  attr_accessor :speed, :heading

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

# Now Alan has asked them to incorporate a new type of vehicle into their system - a Catamaran defined as follows:

class Catamaran
  attr_reader :propeller_count, :hull_count
  attr_accessor :speed, :heading

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    # ... code omitted ...
  end
end

# This new class does not fit well with the object hierarchy defined so far. Catamarans don't have tires.
# But we still want common code to track fuel efficiency and range. Modify the class definitions and move
# code into a Module, as necessary, to share code among the Catamaran and the wheeled vehicles.

module Moveable
  attr_accessor :speed, :keading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Catamaran
  include Moveable

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity

    # ... code omitted ...
  end
end

# Question 2)

# Building on the prior vehicles question, we now must also track a basic motorboat. A motorboat has
# a single propeller and hull, but otherwise behaves similar to a catamaran. Therefore, creators of
# Motorboat instances don't need to specify number of hulls or propellers. How would you modify the
# vehicles code to incorporate a new Motorboat class?

# We can create a new class to present common elements of motorboats and catamarans. We cna call it,
# Seacraft. We will still want to include the moveable module to get support for calculating range.

class Seacraft
  include Moveable

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end
end

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1,1,km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity) # As all arguments authomatically
    # get passed to `super`, we can ommit the arguments and just call `super`. In fact, as `super` is the onl statement
    # in `intialize`, we can remove it all together; `def Catamaran < Seacraft; end`
  end
end

# Question 3)

# The designers of the vehicle management system now want to make an adjustment for how the range of vehicles is
# calculated. For the seaborne vehicles, due to prevailing ocean currents, they want to add an additional 10km
# of range even if the vehicle is out of fuel.

# Alter the code related to vehicles so that the range for autos and motorcycles is still calculated as before,
# but for catamarans and motorboats, the range method will return an additional 10km.

class Seacraft
  include Moveable

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end

  def range # Override the `range` method (from the Moveable module) in the seacraft class by defining a new method
    # within the class.
    super + 10 # We use the `super` keyword to get the value from the `range` in Moveable, then add 10 to the result.
  end
end

=end