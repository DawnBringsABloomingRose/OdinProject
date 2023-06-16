require_relative "modules"

class Piece
  attr_reader :symbol
  MOVES = []
  def initialize(colour, current_location)
    @current_location = current_location
    @colour = colour
    @move_history = []
    @symbol = self.get_symbol
  end

  def valid_move?(move)
    return false if move[0] < 0 || move[0] > 7 || move[1] < 0 || move[1] > 7 
    difference = [move[0] - @current_location[0], move[1] - @current_location[1]]

    self.possible_direction?(difference)
  end
end

class Knight < Piece
  def get_symbol
    return "♘" if @colour == 'black'
    "♞"
  end
end

class King < Piece
  MOVES = [[0,1], [1,1], [1,0], [0,-1], [-1,1], [1,-1], [-1,-1], [-1,0]]
  def get_symbol
    return "♔" if @colour == 'black'
    "♚"
  end
end

class Queen < Piece
  include LinearMovement

  MOVES = [[0,1], [1,1], [1,0], [0,-1], [-1,1], [1,-1], [-1,-1], [-1,0]]

  def get_symbol
    return "♕" if @colour == 'black'
    "♛"
  end

  def possible_direction?(direction)
    direction = normalize_direction(direction)
    MOVES.include?(direction)
  end
end

class Bishop < Piece
  include LinearMovement

  MOVES = [[1,1], [-1,1], [1,-1], [-1,-1]]

  def get_symbol
    return "♗" if @colour == 'black'
    "♝"
  end

  def possible_direction?(direction)
    direction = normalize_direction(direction)
    MOVES.include?(direction)
  end
end

class Pawn < Piece
  def get_symbol
    return "♙" if @colour == 'black'
    "♟︎"
  end
end

class Rook < Piece
  include LinearMovement

  MOVES = [[0,1], [1,0], [-1, 0], [0,-1]]

  def get_symbol
    return "♖" if @colour == 'black'
    "♜"
  end
  
  def possible_direction?(direction)
    direction = normalize_direction(direction)
    MOVES.include?(direction)
  end
end
