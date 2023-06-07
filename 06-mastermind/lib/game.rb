class Game
  attr_accessor :code

  def initialize(player)
    @player = player
    @ai = Ai.new
    @code = Code.new(@ai.make_code) if player == 'b' 
  end

  def make_guess(guess)
    if @player == 'b'
      return @code.take_a_guess(guess)
    end
  end
end