# create a class for the game
class Game
  attr_accessor :answer, :guess, :alphabet
  attr_reader :hangman_pics

  def initialize
    @words = %w[rabbit hello plant cat mouse home burrito]
    @alphabet = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @answer = @words.sample
    @guess = ['']
    @hangman_pics = ['''
      +---+
      |   |
          |
          |
          |
          |
    =========''', '''
      +---+
      |   |
      O   |
          |
          |
          |
    =========''', '''
      +---+
      |   |
      O   |
      |   |
          |
          |
    =========''', '''
      +---+
      |   |
      O   |
     /|   |
          |
          |
    =========''', '''
      +---+
      |   |
      O   |
     /|\  |
          |
          |
    =========''', '''
      +---+
      |   |
      O   |
     /|\  |
     /    |
          |
    =========''', '''
      +---+
      |   |
      O   |
     /|\  |
     / \  |
          |
    =========''']
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
  attr_accessor :lives

  def initialize
    @lives = 6
    @alphabet = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
  end

  def make_guess
    player_guess = ''
    until player_guess.length == 1 && @alphabet.include?(player_guess)
      puts 'Which letter would you like to guess?'
      player_guess = gets.chomp.downcase
      break if player_guess.length == 1 && @alphabet.include?(player_guess)

      puts 'Please choose a single valid letter between a-z.'
    end
    player_guess
  end
end

# game functionality below
loop do
  puts "Welcome to 'Hangman'! Your goal is to guess the secret word, 1 letter at a time, before \
running out of lives. You have 6 lives. Good luck!"
  # create Game & Player class instance
  new_game = Game.new
  new_player = Player.new

  # run initial class methods
  new_game.populate_guess

  puts "Answer for testing purposes: #{new_game.answer}"
  # loop while lives > 0 and player hasn't won
    puts new_game.hangman_pics[6 - new_player.lives]
    puts new_game.guess
    new_player.make_guess

  break
end
