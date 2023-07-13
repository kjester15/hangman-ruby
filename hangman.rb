require 'csv'

# create a class for the game
class Game
  attr_reader :hangman_pics, :answer, :guess, :game_over, :lives
  attr_accessor :words

  def initialize
    @words = []
    @alphabet = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    @guessed_letters = []
    @answer = ''
    @lives = 6
    @guess = []
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

  def load_dictionary
    File.foreach('google-10000-english-no-swears.txt') { |line| @words << line.chomp }
  end

  def populate_guess
    # pick random word for answer
    until @answer.length > 4 && @answer.length < 13
      @answer = @words.sample
    end
    # add underscores to the array for each letter in the answer
    answer.length.times do
      @guess << '_'
    end
  end

  def update_guess(guess)
    # check if letter matches letter in answer > if so, update letter in that position in guess
    # break method if letter was already guessed
    if @guessed_letters.include?(guess)
      puts 'You already tried that letter, pick another!'
      puts
      return
    end

    if @answer.include?(guess)
      # add guessed letter to guess array or remove a life if not in answer
      count = @answer.count(guess)
      if count > 1
        i = -1
        all = []
        while i = @answer.index(guess, i + 1)
          all << i
        end
        all.each { |x| @guess[x] = guess }
      else
        @guess[@answer.index(guess)] = guess
      end
      # end game if word is guessed
      unless @guess.include?('_')
        @game_over = true
      end
    else
      @lives -= 1
      # end game if out of lives
      if @lives == 0
        @game_over = true
      end
    end
    puts "Lives remaining: #{lives}"
    puts
    @guessed_letters << guess
  end

  def win_lose_message(lives)
    if lives.positive?
      puts 'Congrats! You win!'
    else
      # display final hangman image
      puts @hangman_pics[6]
      puts
      puts 'Game over! You lose!'
    end
    puts
  end
end

# create a class for the player
class Player
  attr_accessor :lives

  def initialize
    @alphabet = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
  end

  def make_guess
    # gets a valid guess from the player
    player_guess = ''
    until player_guess.length == 1 && @alphabet.include?(player_guess)
      puts 'Which letter would you like to guess?'
      print 'Guess: '
      player_guess = gets.chomp.downcase
      puts
      break if player_guess.length == 1 && @alphabet.include?(player_guess)

      puts 'Please choose a single valid letter between a-z.'
    end
    player_guess
  end
end

# game functionality below
loop do
  puts
  puts "Welcome to 'Hangman'! Your goal is to guess the secret word, 1 letter at a time, before \
running out of lives. You have 6 lives. Good luck!"

  # create Game & Player class instance
  new_game = Game.new
  new_player = Player.new

  # run initial class methods
  new_game.load_dictionary
  puts new_game.words
  new_game.populate_guess

  # loop while lives > 0 and player hasn't won
  while new_game.lives.positive? && new_game.game_over == false
    puts new_game.hangman_pics[6 - new_game.lives]
    puts
    puts "Answer for testing purposes: #{new_game.answer}"
    puts
    puts "Current Board: #{new_game.guess.join('')}"
    puts
    new_game.update_guess(new_player.make_guess)
  end

  # display win or lose message
  new_game.win_lose_message(new_game.lives)

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
