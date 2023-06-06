class Player
  attr_reader :wins
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
    @wins = 0
  end

  def won
    self.wins += 1
  end
end
