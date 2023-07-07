# create a class for the game
class Game
  attr_accessor :answer

  def initialize
    @words = %w[rabbit hello plant cat mouse home burrito]
    @answer = @words.sample
    @guess = ['']
  end

  def populate_guess
    guess_length = answer.length
    guess_length.times do
      @guess[0] += '_ '
    end
    @guess
  end
end

# create a class for the player
class Player
  def initialize
    
  end
end

# game functionality below

# create Game & Player class instance
new_game = Game.new
new_player = Player.new

puts new_game.answer
puts new_game.populate_guess
