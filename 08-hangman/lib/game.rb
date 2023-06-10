class Game

  def initialize
    @word = Word.new
    @max_guesses = 7
    @current_guesses = 0
    @previous_guesses = []
  end

  def guess(char)
    return false if char.length != 1
    return "You have already guessed that" if @previous_guesses.include?(char)

    @word.take_guess(char)
  end
end