require_relative "modules"

class Piece
  attr_reader :symbol, :current_location
  attr_accessor :current_location
  MOVES = []

  #location: column then row, ex. a1 = [0,0]
  def initialize(colour, current_location)
    @current_location = current_location
    @colour = colour
    @move_history = []
    @symbol = self.get_symbol
  end

  def valid_move?(move, ally_locations = [], enemy_locations = [])
    return false if move[0] < 0 || move[0] > 7 || move[1] < 0 || move[1] > 7 

    difference = [move[0] - @current_location[0], move[1] - @current_location[1]]
    
    #possible_direction checks to make sure the direction is valid
    #clear_to_move checks if there are other pieces in the way that would hinder the move
    return self.possible_direction?(difference) && self.clear_to_move?(move, ally_locations, enemy_locations)
  end

  def make_move(move, allies, enemies)
    @current_location = move if valid_move?(move, allies, enemies)
    
  end
end

class Knight < Piece
  MOVES = [[1,2], [2,1], [1,-2], [2,-1], [-1,2], [-2,1], [-1, -2], [-2,-1]]

  def get_symbol
    return "♘" if @colour == 'black'
    "♞"
  end

  def possible_direction?(direction)
    MOVES.include?(direction)
  end

  def clear_to_move?(move, ally_locations, enemy_locations)
    clear = true
    ally_locations.each do |ally|
      return false if ally.is_a?(Array) && ally == move
      return false if ally.is_a?(Piece) && ally.current_location == move
    end
    clear
  end

  def possible_moves(ally_locations, enemy_locations)
    poss_moves = []
    MOVES.each do |move|
      x_direction = move[0] + @current_location[0]
      y_direction = move[1] + @current_location[1]
      poss_moves.push([x_direction, y_direction]) if self.valid_move?([x_direction, y_direction], ally_locations, enemy_locations)
    end
    poss_moves
  end
end

class King < Piece
  MOVES = [[0,1], [1,1], [1,0], [0,-1], [-1,1], [1,-1], [-1,-1], [-1,0]]
  def get_symbol
    return "♔" if @colour == 'black'
    "♚"
  end

  def possible_direction?(direction)
    return false if direction[0] == 0 && direction[1] == 0
    return false unless direction[0] == 0 || direction[0] == 1
    return false unless direction[1] == 0 || direction[1] == 1
    true
  end

  def clear_to_move?(move, ally_locations, enemy_locations)
    clear = true
    ally_locations.each do |ally|
      return false if ally.is_a?(Array) && ally == move
      return false if ally.is_a?(Piece) && ally.current_location == move
    end
    clear
  end

  def possible_moves(ally_locations, enemy_locations)
    poss_moves = []
    MOVES.each do |move|
      x_direction = move[0] + @current_location[0]
      y_direction = move[1] + @current_location[1]
      poss_moves.push([x_direction, y_direction]) if self.valid_move?([x_direction, y_direction], ally_locations, enemy_locations)
    end
    poss_moves
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
  
  def give_moves
    MOVES
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

  def give_moves
    MOVES
  end
end

class Pawn < Piece
  attr_reader :first_move, :en_passable
  def initialize(colour, current_location)
    super
    @first_move = true
    @en_passable = false
  end

  def made_passable
    @en_passable = true
  end

  def make_unpassable
    @en_passable = false
  end

  def get_symbol
    return "♙" if @colour == 'black'
    "♟︎"
  end

  def possible_moves(ally_locations, enemy_locations)
    allowed_direction = 1 if @colour == 'black'
    allowed_direction = -1 if @colour == 'white'
    moves = [[0,1*allowed_direction], [0, 2*allowed_direction], [1, 1 * allowed_direction], [-1, 1 * allowed_direction]]
    poss_moves = []

    moves.each do |i|
      x_direction = i[0] + @current_location[0]
      y_direction = i[1] + @current_location[1]
      poss_moves.push([x_direction, y_direction]) if self.valid_move?([x_direction, y_direction], ally_locations, enemy_locations)
    end
    poss_moves
  end

  def valid_move?(move, ally_locations = [], enemy_locations = [])
    return false if move[0] < 0 || move[0] > 7 || move[1] < 0 || move[1] > 7 

    difference = [move[0] - @current_location[0], move[1] - @current_location[1]]
    allowed_direction = 1 if @colour == 'black'
    allowed_direction = -1 if @colour == 'white'

    p difference
    if difference[0] == 0
      if difference[1] == 2 * allowed_direction
        ally_locations.each do |ally|
          return false if ally.is_a?(Array) && ally == move || ally == [move[0], move[1] - allowed_direction]
          return false if ally.is_a?(Piece) && ally.current_location == move || ally.current_location == [move[0], move[1] - allowed_direction]
        end
        enemy_locations.each do |enemy|
          return false if enemy.is_a?(Array) && enemy == move || enemy == [move[0], move[1] - allowed_direction]
          return false if enemy.is_a?(Piece) && enemy.current_location == move || enemy.current_location == [move[0], move[1] - allowed_direction]
        end
        return true if @first_move
        return false
      elsif difference[1] == 1 * allowed_direction
        ally_locations.each do |ally|
          return false if ally.is_a?(Array) && ally == move
          return false if ally.is_a?(Piece) && ally.current_location == move
        end
        enemy_locations.each do |enemy|
          return false if enemy.is_a?(Array) && enemy == move
          return false if enemy.is_a?(Piece) && enemy.current_location == move
        end
        return true
      end
      #if it stays in the lane but moves some number other than 2 or 1 units forward, return false
      return false
    
      #if the pawn goes out of its lane, it must be attempting to take an enemy piece or else it is not a valid move
    else
      if difference[0].abs == 1 && difference[1] == allowed_direction
        enemy_locations.each do |enemy|
          #takes this piece; returns true if the move is to the enemy location
          return true if enemy.is_a?(Array) && enemy == move
          return true if enemy.is_a?(Piece) && enemy.current_location == move
          
          #en_passant
          #return true if enemy.is_a?(Array) && enemy == [move[0], move[1] - allowed_direction]
          return true if enemy.is_a?(Piece) && enemy.current_location == [move[0], move[1] - allowed_direction] && enemy.is_a?(Pawn) && enemy.en_passable
        end
      end
      return false
    end
  end

  def make_move(move, ally, enemy)
    super
    @first_move = false
    @en_passable = true
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

  def give_moves
    MOVES
  end
end
