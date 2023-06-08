class Game
  attr_accessor :code, :prev_guesses

  def initialize(player)
    @player = player
    @ai = Ai.new
    @code = Code.new(@ai.make_code) if player == 'b' 
    @code = Code.new(@ai.make_code) if player == 'm' 
    @prev_guesses = []
  end

  def ai_play
    guess = @ai.first_guess
    first_feedback = code.take_a_guess(guess)
    feedback = first_feedback
    until feedback.is_a? Integer do
      puts "#{guess} was not it! #{feedback}"
      @ai.eliminate_guesses(guess, feedback)
      guess = @ai.next_guess
      feedback = code.take_a_guess(guess)
    end
    puts "You got it! It took #{feedback} to guess #{guess}"
  end

  def make_guess(guess)
    @prev_guesses.push(guess)
    if @player == 'b'
      return @code.take_a_guess(guess)
    end
  end
end