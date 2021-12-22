# frozen_string_literal: true

require 'json'
require_relative 'hangman'

# Initialize and launch new game of hangman
class HangmanLauncher
  def play
    puts 'Welcome to Ruby Hangman! Would you like to start a new game or load a saved game?'
    puts ''
    puts '1 - New game'
    puts '2 - Load game'
    puts ''
    game_type = prompt_user_gametype
    puts ''

    if game_type == '1'
      new_game
    else
      puts 'Enter path to saved game (e.g., \'./saved_games/example.json\'): '
      saved_game_file = gets.chomp
      load_game(saved_game_file)
    end
  end

  private

  def prompt_user_gametype
    loop do
      user_input = gets.chomp

      return user_input if %w[1 2].include?(user_input)

      puts ''
      puts 'Invalid input - Please enter \'1\' (new game) or \'2\' (load game)'
    end
  end

  def new_game
    dictionary = load_dictionary
    random_word = dictionary.sample
    HangmanGame.new(random_word).play
  end

  def load_dictionary
    dictionary = []
    File.open('5desk.txt').readlines.each do |line|
      dictionary << line.chomp if line.chomp.length > 4 && line.chomp.length < 13
    end
    dictionary
  end

  def read_saved_game(file)
    File.open(file, 'r').read
  end

  def load_game(file)
    string = read_saved_game(file)
    HangmanGame.from_json(string).play
  end
end

HangmanLauncher.new.play
