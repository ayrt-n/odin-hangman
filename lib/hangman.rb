# Play hangman game
class HangmanGame
  attr_reader :word, :guess
  attr_accessor :remaining_incorrect_guesses

  def initialize(word)
    @word = word
    @guess = '_' * word.length
    @remaining_incorrect_guesses = 6
    @remaining_letters = ('A'..'Z').to_a
  end

  def play
    hangman_game
    print_full_game_view
    puts win? ? 'Congratulations, you won!' : "Game over! The word was #{word}."
    puts ''
  end

  def hangman_game
    until win? || lose?
      print_full_game_view
      user_guess = prompt_user_guess
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
    print 'Enter letter: '
    gets.chomp
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
    puts ''
    print_hangman
    puts ''
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

  def print_remaining_guesses
    puts "Remaining incorrect guesses: #{remaining_incorrect_guesses}"
  end
end

dictionary = []
File.open('5desk.txt').readlines.each do |line|
  if line.chomp.length > 4 && line.chomp.length < 13
    dictionary << line.chomp
  end
end

random_word = dictionary.sample

game = HangmanGame.new(random_word)

game.play
