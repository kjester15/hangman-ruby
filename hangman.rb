# create a class for the game
class Game
  attr_reader :hangman_pics, :answer, :guess, :game_over

  def initialize
    @words = %w[rabbit hello plant cat mouse home burrito]
    @alphabet = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @answer = @words.sample
    @guess = ['']
    @game_over = false
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
    answer.length.times do
      @guess[0] += '_ '
    end
    @guess
  end

  def update_guess(guess)
    # check if letter matches letter in answer > if so, update letter in that position in guess
    if @answer.include?(guess)
      puts 'test'
    end
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

  # loop while lives > 0 and player hasn't won
  while new_player.lives.positive? && new_game.game_over == false
    puts new_game.hangman_pics[6 - new_player.lives]
    puts
    puts "Answer for testing purposes: #{new_game.answer}"
    puts
    puts "Current Guess: #{new_game.guess[0]}"
    puts
    guess = new_player.make_guess
    new_game.update_guess(guess)
  end

  # ask to play another game
  answer = ''
  until answer == 'yes' || answer == 'no'
    puts 'Would you like to play again?'
    answer = gets.chomp.downcase
    break if answer == 'yes' || answer == 'no'

    puts "Please answer with 'yes' or 'no'"
  end
  break if answer == 'no'
end
