# create a class for the game
class Game
  attr_accessor :answer

  def initialize
    @words = %w[rabbit hello plant cat mouse home burrito]
    @answer = @words.sample
  end
end

# create a class for the player
class Player
  def initialize
    
  end
end

# game functionality below
new_game = Game.new

puts new_game.answer
