class Game
  attr_accessor :code, :prev_guesses

  def initialize(player, code=0)
    @player = player
    @ai = Ai.new
    @code = Code.new(@ai.make_code) if player == 'b' 
    @code = Code.new(code) if player == 'm' 
    @prev_guesses = []
  end

  def ai_play
    guess = @ai.next_guess
    feedback = make_guess(guess)
    @ai.eliminate_guesses(guess, feedback)
    feedback
  end

  def make_guess(guess)
    @prev_guesses.push(guess)
    return @code.take_a_guess(guess)
  end
end