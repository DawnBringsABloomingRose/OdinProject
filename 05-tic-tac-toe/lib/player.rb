class Player
  attr_reader :wins, :name
  attr_accessor :symbol

  def initialize(symbol, name)
    @symbol = symbol
    @name = name
    @wins = 0
  end

  def won
    self.wins += 1
  end
end
