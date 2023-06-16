class Piece
  attr_reader :symbol
  def initialize(colour, current_location)
    @current_location = current_location
    @colour = colour
    @move_history = []
    @symbol = self.get_symbol
  end
end

class Knight < Piece
  def get_symbol
    return "♘" if @colour == 'black'
    "♞"
  end
end

class King < Piece
  def get_symbol
    return "♔" if @colour == 'black'
    "♚"
  end
end

class Queen < Piece
  def get_symbol
    return "♕" if @colour == 'black'
    "♛"
  end
end

class Bishop < Piece
  def get_symbol
    return "♗" if @colour == 'black'
    "♝"
  end
end

class Pawn < Piece
  def get_symbol
    return "♙" if @colour == 'black'
    "♟︎"
  end
end

class Rook < Piece
  def get_symbol
    return "♖" if @colour == 'black'
    "♜"
  end
end