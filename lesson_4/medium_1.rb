################################## RB 120 Lesson 4 ########################################

# Practice Problems: Medium 1

# Question 1)

# Ben asked Alyssa to code review the following code:

# class BankAccount
#   attr_reader :balance

#   def initialize(starting_balance)
#     @balance = starting_balance
#   end

#   def positive_balance?
#     balance >= 0
#   end
# end

# Alyssa glanced over the code quickly and said - "It looks fine, except that you forgot
# to put the @ before balance when you refer to the balance instance variable in the body
# of the positive_balance? method."
# "Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an @!"
# Who is right, Ben or Alyssa, and why?

# Ben is right, we have a getter method (attr_reader) for @balance and that can be used to compared against 0.

# Question 2)

# Alan created the following code to keep track of items for a shopping cart application he's writing:

# class InvoiceEntry
#   attr_reader :quantity, :product_name

#   def initialize(product_name, number_purchased)
#     @quantity = number_purchased
#     @product_name = product_name
#   end

#   def update_quantity(updated_count)
#     # prevent negative quantities from being set
#     quantity = updated_count if updated_count >= 0
#   end
# end

# Alyssa looked at the code and spotted a mistake. "This will fail when update_quantity is called", she says.
# Can you spot the mistake and how to address it?

# Since `quantity` is an instance variable, it must be accessed with the `@quantity` notation when setting it.

# Two possible solutions.
# Update attr_reader to attr_accessor then use a setter method like `self.quantity =...`
# Or
# Reference the instance variable itself with `@quantity =... `

# Question 3)

# In the last question Alan showed Alyssa this code which keeps track of items for a shopping cart application:

# class InvoiceEntry
#   attr_reader :quantity, :product_name

#   def initialize(product_name, number_purchased)
#     @quantity = number_purchased
#     @product_name = product_name
#   end

#   def update_quantity(updated_count)
#     quantity = updated_count if updated_count >= 0
#   end
# end

# Alyssa noticed that this will fail when update_quantity is called. Since quantity is an instance variable,
#  it must be accessed with the @quantity notation when setting it. One way to fix this is to change attr_reader
#   to attr_accessor and change quantity to self.quantity.
# Is there anything wrong with fixing it this way?

# Nothing incorrect syntactically. However, you are altering the public interfaces of the class. In other words,
# you are now allowing clients of the class to change the quantity directly (calling the accessor with the
# instance.quantity = <new value> notation) rather than by going through the update_quantity method. It means
# that the protections built into the update_quantity method can be circumvented and potentially pose problems
# down the line.

# Question 4)
# Let's practice creating an object hierarchy.

# Create a class called Greeting with a single instance method called greet that takes a string argument and prints
#  that argument to the terminal.

# Now create two other classes that are derived from Greeting: one called Hello and one called Goodbye. The Hello 
# class should have a hi method that takes no arguments and prints "Hello". The Goodbye class should have a bye method
# to say "Goodbye". Make use of the Greeting class greet method when implementing the Hello and Goodbye classes -
# do not use any puts in the Hello or Goodbye classes.

# class Greeting
#   def greet(str)
#     puts str
#   end
# end

# def Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

# def Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# Question 5)

# # You are given the following class that has been implemented:

# class KrispyKreme
#   def initialize(filling_type, glazing)
#     @filling_type = filling_type
#     @glazing = glazing
#   end
# end

# # And the following specification of expected behavior:

# donut1 = KrispyKreme.new(nil, nil)
# donut2 = KrispyKreme.new("Vanilla", nil)
# donut3 = KrispyKreme.new(nil, "sugar")
# donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
# donut5 = KrispyKreme.new("Custard", "icing")

# puts donut1
#   # => "Plain"

# puts donut2
#   # => "Vanilla"

# puts donut3
#   # => "Plain with sugar"

# puts donut4
#   # => "Plain with chocolate sprinkles"

# puts donut5
#   # => "Custard with icing"

# # Write additional code for KrispyKreme such that the puts statements will work as specified above.

# Additional code:
# def to_s
#   filling_string = @filling_type ? @filling_type : "Plain"
#   glazing_string = @glazing ? " with #{@glazing}" : ""
#   filling_string + glazing_string
# end

# Queston 6)

# If we have these two methods in the Computer class:

# class Computer
#   attr_accessor :template

#   def create_template
#     @template = "template 14231"
#   end

#   def show_template
#     template
#   end
# end

# and

# class Computer
#   attr_accessor :template

#   def create_template
#     @template = "template 14231"
#   end

#   def show_template
#     self.template
#   end
# end

# What is the difference in the way the code works?

# There's actually no difference in the result, only in the way each example accomplishes the task.
#  Compare both show_template methods. We can see in the first example that it works fine without self,
#   therefore, self isn't needed in the second example. This is because show_template invokes the getter
#    method template, which doesn't require self, unlike the setter method.

# Both examples are technically fine, however, the general rule from the Ruby style guide is to
#  "Avoid self where not required."

# Question 7)

# How could you change the method name below so that the method name is more clear and less repetitive?

# class Light
#   attr_accessor :brightness, :color

#   def initialize(brightness, color)
#     @brightness = brightness
#     @color = color
#   end

#   def light_status
#     "I have a brightness level of #{brightness} and a color of #{color}"
#   end
# end

# Currently the method is defined as light_status, which seems reasonable. But when using or invoking the
# method, we would call it like this: my_light.light_status. Having the word "light" appear twice is redundant.
# Therefore, we can rename the method to just status, and we can invoke it like as my_light.status. This reads
# much better -- remember, you're writing code to be readable by others as well as your future self.