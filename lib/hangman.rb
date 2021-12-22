# frozen_string_literal: true

require 'json'

# Contains logic required to play game of hangman
class HangmanGame
  attr_reader :word, :guess, :remaining_incorrect_guesses

  def initialize(
    word,
    guess = '_' * word.length,
    remaining_incorrect_guesses = 6,
    remaining_letters = ('A'..'Z').to_a
  )
    @word = word
    @guess = guess
    @remaining_incorrect_guesses = remaining_incorrect_guesses
    @remaining_letters = remaining_letters
  end

  def self.from_json(file)
    game_state = JSON.load(file)
    self.new(
      game_state['word'],
      game_state['guess'],
      game_state['remaining_incorrect_guesses'],
      game_state['remaining_letters']
    )
  end

  def to_json
    JSON.dump ({
      word: @word,
      guess: @guess,
      remaining_incorrect_guesses: @remaining_incorrect_guesses,
      remaining_letters: @remaining_letters
    })
  end

  def play
    hangman_game
    puts ''
    if win? 
      puts 'Congratulations, you won!' 
    elsif lose? 
      puts "Game over! The word was #{word}."
    else
      save_game
      puts 'Game saved. Thank you!'
    end
    puts ''
  end

  private

  def save_game
    dirname = 'saved_games'
    print 'Name: '
    filename = gets.chomp
    puts ''
    Dir.mkdir(dirname) unless File.exist?(dirname)
    File.open("#{dirname}/#{filename}.json", 'w') { |f| f.write(to_json) }
  end

  def hangman_game
    loop do
      print_full_game_view
      break if win? || lose?

      user_guess = prompt_user_guess
      break if user_guess == 'save'

      update_current_guess(user_guess)
      update_remaining_letters(user_guess)
      @remaining_incorrect_guesses -= 1 unless word.downcase.include?(user_guess.downcase)
    end
  end

  def win?
    word == guess
  end

  def lose?
    remaining_incorrect_guesses.zero?
  end

  def update_remaining_letters(char)
    @remaining_letters -= char.upcase.split('')
  end

  def prompt_user_guess
    loop do
      print 'Enter letter (type \'save\' to save game and quit): '
      user_guess = gets.chomp

      return user_guess if @remaining_letters.include?(user_guess.upcase) || user_guess == 'save'

      puts ''
      puts 'Invalid input - Please enter one of the remaining letters or \'save\''
      puts ''
    end
  end

  def update_current_guess(char)
    word.split('').each_with_index do |val, idx|
      guess[idx] = val if val.downcase == char.downcase
    end
  end

  def print_full_game_view
    puts ''
    print_remaining_guesses
    puts ''
    print_hangman
    puts ''
    print_current_guess
    puts ''
    print_remaining_letters
    puts ''
  end

  def print_current_guess
    puts "Word: #{guess.split('').join(' ')}"
  end

  def print_remaining_letters
    puts "Remaining letters: #{@remaining_letters.join(' ')}"
  end

  def print_remaining_guesses
    puts "Remaining incorrect guesses: #{remaining_incorrect_guesses}"
  end

  def print_hangman
    puts "   ______ "
    puts "  |      |"
    puts "  |    #{hangman_head}"
    puts "  |    #{hangman_l_arm}#{hangman_body}#{hangman_r_arm}"
    puts "  |    #{hangman_l_leg}   #{hangman_r_leg}"
    puts " _|_"
  end

  def hangman_head
    if remaining_incorrect_guesses <= 5
      "(x_x)"
    end
  end

  def hangman_body
    if remaining_incorrect_guesses <= 4
      "|_|"
    else
      " "
    end
  end

  def hangman_l_arm
    if remaining_incorrect_guesses <= 3
      "/"
    else
      " "
    end
  end

  def hangman_r_arm
    if remaining_incorrect_guesses <= 2
      "\\"
    else
      " "
    end
  end

  def hangman_l_leg
    if remaining_incorrect_guesses <= 1
      "/"
    else
      " "
    end
  end

  def hangman_r_leg
    if remaining_incorrect_guesses <= 0
      "\\"
    else
      " "
    end
  end
end
