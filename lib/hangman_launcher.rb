require_relative 'hangman'

# Initialize and launch new game of hangman
class HangmanLauncher
  def play
    dictionary = load_dictionary
    random_word = dictionary.sample
    HangmanGame.new(random_word).play
  end

  def load_dictionary
    dictionary = []
    File.open('5desk.txt').readlines.each do |line|
      dictionary << line.chomp if line.chomp.length > 4 && line.chomp.length < 13
    end
  end
end

HangmanLauncher.play
