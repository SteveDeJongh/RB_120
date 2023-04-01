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

# 3)

### Dental Office Alumni (by Rona Hsu) 8 minutes.

# There's a dental office called Dental People Inc.  Within this office, there's 2 oral surgeons, 2 orthodontists, 1 general dentist.
# Both general dentists and oral surgeons can pull teeth. Orthodontists cannot pull teeth.  Orthodontists straighten teeth.
# All of these aforementioned specialties are dentists. All dentists graduated from dental school.  Oral surgeons place implants.
# General dentists fill teeth

Nouns: Dental office, oral surgeon, orthodontists, general dentist. dentists, dental school
Verbs: pull teeth, straighten teeth, place implants, fill teeth

module PullTeethable
  def pull_teeth
    "Pulling the tooth!"
  end
end

class DentalOffice
  def initialize
    @staff = []
    2.times { @staff << OralSurgeon.new}
    2.times { @staff << Orthodonsist.new}
    1.times { @staff << GeneralDentist.new}
  end
end

class Dentist
  def initialize
    @dentalschool = true
  end
end

class OralSurgeron < Dentist
  include PullTeethable

  def place_implant
    "Get in there implant!"
  end
end

class Orthodonsist < Dentist
  def straighten_teeth
    "Straightening the tooth!"
  end
end

class GeneralDentist < Dentist
  include PullTeethable

  def fill_teeth
    "Filling da tooth!"
  end
end

=end

=begin

Design a Sports Team (Author Unknown...thank you!)

- Include 4 players (attacker, midfielder, defender, goalkeeper)
- All the players’ jersey is blue, except the goalkeeper, his jersey is white with blue stripes
- All players can run and shoot the ball.
- Attacker should be able to lob the ball
- Midfielder should be able to pass the ball
- Defender should be able to block the ball
- The referee has a whistle. He wears black and is able to run and whistle.

nouns: player, attacker, midfielder, defender, goalkeeper, referee
verbs: run, shoot the ball, lob the ball, pass the ball, block the ball, whistle,

module Runable
  def run
    "Running!"
  end
end


class Player
  include Runable

  def initialize(jersey)
    @jersey_color = jersey
  end

  def shoot
    "shooting the ball!"
  end
end

class Attacker < Player
  def initialize
    super('blue')
  end

  def lob
    "Lobbing!"
  end
end

class Midfielder < Player
  def initialize
    super('blue')
  end

  def pass
    "Passing!"
  end
end

class Defender < Player
  def initialize
    super('blue')
  end

  def block
    "Blocking!"
  end
end

class Goalkeeper < Player
  def initialize
    super('white')
  end
end

class Referee
  include Runable

  def initialize
    @whistle = true
  end

  def whistle
    "Whistling!"
  end
end

player = Player.new('blue')
attacker = Attacker.new
midfielder = Midfielder.new
defender = Defender.new
goalkeeper = Goalkeeper.new
ref = Referee.new
p player
p attacker
p midfielder
p defender
p goalkeeper
p ref

[player, attacker, midfielder, defender, goalkeeper, ref].each {|person| p person.run}
p attacker.lob
p midfielder.pass
p defender.block
p ref.whistle

=end