require 'json'

#used for pieces that can move linearly without range constraints, ie the queen, rook and bishop
module LinearMovement
  
  #it takes in a vector, normalizes it, then returns the normalized vector rounded up if the vector has a 45 degree angle (ie [0.71, -0.71] becomes [1,-1])
  #returns the normalized vector otherwise
  def normalize_direction(direction)
    magnitude = Math.sqrt(direction[0]**2 + direction[1]**2)
    direction[0] = direction[0]/magnitude
    direction[1] = direction[1]/magnitude
    direction = [direction[0].round, direction[1].round] if direction[0].abs.round(2) == direction[1].abs.round(2)
    direction
  end

  def clear_to_move?(move, ally_locations, enemy_locations)
    difference = [move[0] - @current_location[0], move[1] - @current_location[1]]
    direction = normalize_direction(difference)
    clear = true


    submoves = []
    submoves.push(move)
    x = current_location[0] + direction[0]
    y = current_location[1] + direction[1]
    while x != move[0] && y != move[1] do
      submoves.push([x,y])
      x += direction[0]
      y += direction[1]
    end

    ally_locations.each do |ally|
      clear = !submoves.include?(ally) if ally.is_a? Array
      clear = !submoves.include?(ally.current_location) if ally.is_a? Piece
      return clear unless clear
    end

    enemy_locations.each do |enemy|
      next if enemy.is_a?(Array) && enemy == move
      next if enemy.is_a?(Piece) && enemy.current_location == move

      clear = !submoves.include?(enemy) if enemy.is_a? Array
      clear = !submoves.include?(enemy.current_location) if enemy.is_a? Piece
      return clear unless clear
    end
    clear
  end

  def possible_moves(ally_locations, enemy_locations)
    poss_moves = []
    
    self.give_moves.each do |move|
      8.times do |i|
        x_direction = move[0] * (i+1) + @current_location[0]
        y_direction = move[1] * (i+1) + @current_location[1]
        poss_moves.push([x_direction, y_direction]) if self.valid_move?([x_direction, y_direction], ally_locations, enemy_locations)
      end
    end
    poss_moves
  end
end

#to_serialize_objects
module BasicSerializable

  @@serializer = JSON 

  def serialize 
    obj = {}
    obj[:class] = self.class.name
    instance_variables.map do |var|
      obj[var] = instance_variable_get(var)
    end
    @@serializer.dump obj
  end

  def unserialize(string)
    obj = @@serializer.parse(string)
    obj.keys.each do |key|
      instance_variable_set(key, obj[key]) unless key == 'class'
    end
  end
end
