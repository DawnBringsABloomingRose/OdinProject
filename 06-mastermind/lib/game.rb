class Game
  attr_accessor :code, :prev_guesses

  def initialize(player)
    @player = player
    @ai = Ai.new
    @code = Code.new(@ai.make_code) if player == 'b' 
    @prev_guesses = []
  end

  def make_guess(guess)
    @prev_guesses.push(guess)
    if @player == 'b'
      return @code.take_a_guess(guess)
    end
  end
end