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

=end

# 3) Fix the program - Books (Part 1)



# 4) Fix the program - Books (Part 2)
# 5) Fix the program - Persons
# 6) Fix the program - Flight Data
# 7) Biggy Code - Car Mileage
# 8) Rectangles and Squares
# 9) Complete the Program - Cats!
# 10) Refacotring Vehicles