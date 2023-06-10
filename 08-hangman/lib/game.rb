class Game
  attr_reader :game_over

  def initialize
    @word = Word.new
    @max_guesses = 7
    @current_guesses = 0
    @previous_guesses = []
    @game_over = false
  end

  def guess(char)
    return "Please only guess 1 character at a time" if char.length != 1
    return "You have already guessed that, try again" if @previous_guesses.include?(char)

    @previous_guesses.push(char)
    @word.take_guess(char)
    @current_guesses+=1 unless @word.word_includes?(char)

    @game_over = true if @word.won? || @current_guesses >= @max_guesses

    return "You won! The word was #{@word.word}" if @word.won?
    return "You lose! Sorry!" if @current_guesses >= @max_guesses
    return "#{char} was in the word!" if @word.word_includes?(char)
    "#{char} was not in the word"
  end

  def current_status
    puts "You have used #{@current_guesses} guesses of your #{@max_guesses} allowed wrong guesses"
    puts "You have guessed these letters so far: #{print_guesses}"
    puts "\nWord: #{@word.neat_print_guess}"
  end

  def print_guesses
    return "none" if @previous_guesses.length == 0

    @previous_guesses.join(', ')
  end
end