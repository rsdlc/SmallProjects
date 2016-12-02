# class LayingHen
#   def initialize
#   end

#   # Ages the hen one month, and lays 4 eggs if the hen is older than 3 months
#   def age!
    
#   end  
# end

# class Egg

# end

class LayingHen

  def initialize
    @age = 0
    @eggs = []
  end

  # Ages the hen one month, and lays 4 eggs if the hen is older than 3 months
  def age!
    @age = @age + 1
    if @age > 3
      4.times do
        @eggs << Egg.new
      end
    end
    self
  end

  # Returns +true+ if the hen has laid any eggs, +false+ otherwise
  def any_eggs?
    !@eggs.empty?
  end

  # Returns an Egg if there are any
  # Raises a NoEggsError otherwise
  def pick_an_egg!
    raise NoEggsError, "The hen has not layed any eggs" unless self.any_eggs?
      @eggs.shift
    # egg-picking logic goes here
  end

  # Returns +true+ if the hen can't laid eggs anymore because of its age, +false+ otherwise.
  # The max age for a hen to lay eggs is 10 
  def old?
    @age > 10 ? true : false
  end

  def increase_hatched_hour(hours)
    @eggs.each do |egg|
      egg.hatched_hours = egg.hatched_hours + hours
    end
    self
  end


end

class Egg
  attr_accessor :hatched_hours
  # Initializes a new Egg with hatched hours +hatched_hours+
  def initialize
    @hatched_hours = 0
  end

  # Return +true+ if hatched hours is greater than 3, +false+ otherwise
  def rotten?
    @hatched_hours > 3 ? true : false
  end
end


