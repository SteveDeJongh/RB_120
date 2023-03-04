#### RB120 Object Oritented Programming: Easy 2 ####

=begin
# 1) Fix the Program - Mailable

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable

  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  include Mailable
  
  attr_reader :name, :address, :city, :state, :zipcode
end

betty = Customer.new 
bob = Employee.new
betty.print_address
bob.print_address

# 2) Fix the Program - Driveable
module Drivable
  def drive # Remove self, methods within modules should be defined without `self`.
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive

# 3) Complete The Program - Houses

class House
  attr_reader :price
  include Comparable #including the `Comparable` mixin.

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# And this output:
# Home 1 is cheaper
# Home 2 is more expensive

# 4) Reverse Engineering
#Desired diplay:

# ABC
# xyz

# From this code:

# my_data = Transform.new('abc')
# puts my_data.uppercase
# puts Transform.lowercase('XYZ')

class Transform
  def initialize(s)
    @letters = s
  end

  def uppercase # Instance method
    @letters.upcase
  end

  def self.lowercase(let) # Class method
    let.downcase
  end

end

my_data = Transform.new('abc')
puts my_data.uppercase #calling instance method.
puts Transform.lowercase('XYZ') #Calling Class method.

# 5) What Will this do?
class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata # Instance method.
    @data + @data
  end

  def self.dupdata # Class method
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata #=> "ByeBye" # Class method
puts thing.dupdata #=> "HelloHello" # Instance method

# 6) Comparing Wallets
class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected # restricts access to below methods to only calls from other objects of this class.

  attr_reader :amount
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end

# 7) Pet Shelter
class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{type} named #{name}"
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    pets.size
  end

  def print_pets
    puts pets
  end
end

class Shelter
  attr_reader :owners, :shelter_pets
  
  def initialize
    @owners = {}
    @shelter_pets = []
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end

  def accept_pet(pet)
    @shelter_pets << pet
  end

  def print_shelter_animals
    puts "The Animal Shelter has the following unadopted pets:"
    @shelter_pets.each do |type, name|
      puts "a #{type} named #{name}"
    end
    puts
  end

  def print_adoptions
    @owners.each_pair do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end

end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
dogd1        = Pet.new('dog', 'd1')
dogd2        = Pet.new('dog', 'd2')
catc1        = Pet.new('cat', 'c1')


phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.accept_pet(dogd1)
shelter.accept_pet(dogd2)
shelter.accept_pet(catc1)
shelter.print_shelter_animals
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

# 8) Moving

module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

class Person
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
p mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
p kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
p flash.walk
# => "Flash runs forward"

# 9) Nobility

module Walkable
  def walk
    "#{self} #{gait} forward"
  end
end

class Person
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end
  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  private

  def gait
    "runs"
  end
end

class Noble
  attr_reader :title, :name

  include Walkable
  def initialize(name, title)
    @name = name
    @title = title
  end

  def to_s
    "#{title} #{name}" # Could also be :@title + " " + @name but string interpolation is preferred.
  end

  def gait
    "struts"
  end
end

byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"

=end