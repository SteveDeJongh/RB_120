########## RB 129 Practice Problem spikes #######
=begin
# 1)

# Design a Sports Team (Author Unknown...thank you!)
# - Include 4 players (attacker, midfielder, defender, goalkeeper)
# - All the players’ jersey is blue, except the goalkeeper, his jersey is white with blue stripes
# - All players can run and shoot the ball.
# - Attacker should be able to lob the ball
# - Midfielder should be able to pass the ball
# - Defender should be able to block the ball
# - The referee has a whistle. He wears black and is able to run and whistle.


module Runable
  def run
    "Running!"
  end
end

class Player
  include Runable
  def initialize
    @jersey_color = 'blue'
  end

  def shoot
    "Shoot!"
  end
end

class Attacker < Player
  def lob
    "Lob!"
  end
end

class Midfielder < Player
  def pass
    "Passing!"
  end
end

class Defender < Player
  def block
    "Blocked!"
  end
end

class Goalkeeper < Player
  def initialize
    @jersey_color = 'white with blue stripes'
  end
end

class Referee
  include Runable

  def initialize
    @whistle = true
    @jersey_color = 'black'
  end

  def whistle
    "Whistling!"
  end
end

p Referee.new.whistle #=> Whistling!

=end

#2) 
# Preschool (by Natalie Thompson) ~ 10 minutes

# Inside a preschool there are children, teachers, class assistants, a principle, janitors, and cafeteria workers.
# Both teachers and assistants can help a student with schoolwork and watch them on the playground. A teacher teaches
# and an assistant helps kids with any bathroom emergencies. Kids themselves can learn and play. A teacher and
# principle can supervise a class. Only the principle has the ability to expel a kid. Janitors have the ability
# to clean. Cafeteria workers have the ability to serve food. Children, teachers, class assistants, principles,
# janitors and cafeteria workers all have the ability to eat lunch.

# Nouns: Preschool, Children, teachers, class assistants, principle, janitors, cafeteria workers
# Verbs: help with schoolwork, watch playground, teaches, helps with bathroom emergencies, learn, play, supervise a class, expel, clean, serve food,
# eat lunch.

module schoolworkalbe
  def help_with_school_work
    "Helping with your schoolwork!"
  end
end

module superviseplaygroundable
  def watch_playground
    "Keeping an eye on the kids in the playground!"
  end
end

module superviseclassable
  def watch_class
    "Keeping an eye on the kids in the classroom!"
  end
end

class Preschool
  def eat_lunch
    "Nom nom nom nom!"
  end
end

class Principle < Preschool
  include superviseclassable

  def expel
    "You have been expelled!"
  end
end

class Teachers < Preschool
  include schoolworkalbe
  include superviseplaygroundable
  include superviseclassable

  def teach
    "Teaching!"
  end
end

class ClassAssistants < Preschool
  include schoolworkalbe
  include superviseplaygroundable

  def bathroom_emergency
    "Taking a kid to the loo!"
  end
end

class Janitors < Preschool
  def clean
    "Cleaning!"
  end
end

class CafeteriaWorkers < Preschool
  def serve_food
    "Take the food!"
  end
end

class Children < Preschool
  def learn
    "learning!"
  end

  def play
    "playing!"
  end
end
