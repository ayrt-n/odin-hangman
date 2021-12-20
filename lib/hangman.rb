class HangmanGame
  attr_reader :word :remaining_guesses

  def initialize(word)
    @word = word
    @remaining_guesses = 6
  end

  def print_word
    puts "_ _ _ _ _ _ _"
  end

  def print_hangman
    puts ""
    puts "  ______ "
    puts " |      |"
    puts " |    #{hangman_head}"
    puts " |    #{hangman_l_arm}#{hangman_body}#{hangman_r_arm}"
    puts " |    #{hangman_l_leg}   #{hangman_r_leg}"
    puts "_|_"
    puts ""
  end

  def hangman_head
    if remaining_guesses == 5
      "(x_x)"
    end
  end

  def hangman_body
    if remaining_guesses == 4
      "| |"
    end
  end

  def hangman_l_arm
    if remaining_guesses == 3
      "/"
    end
  end
  
  def hangman_r_arm
    if remaining_guesses == 2
      "\\"
    end
  end

  def hangman_l_leg
    if remaining_guesses == 1
      "/"
    end
  end

  def hangman_r_leg
    if remaining_guesses == 0
      "\\"
    end
  end

  def print_remaining_guesses
    puts ""
    puts "Remaining guesses: #{remaining_guesses}"
    puts ""
  end
end

dictionary = []
File.open('5desk.txt').readlines.each do |line|
  if line.chomp.length > 4 && line.chomp.length < 13
    dictionary << line
  end
end

random_word = dictionary.sample

HangmanGame.new(random_word)