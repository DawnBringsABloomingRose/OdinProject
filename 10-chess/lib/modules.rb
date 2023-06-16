module LinearMovement
  
  #it takes in a vector, normalizes it, then returns [1,1] if the vector has a 45 degree angle
  #returns the normalized vector otherwise
  def normalize_direction(direction)
    magnitude = Math.sqrt(direction[0]**2 + direction[1]**2)
    direction[0] = direction[0]/magnitude
    direction[1] = direction[1]/magnitude
    direction = [1,1] if direction[0].abs.round(2) == direction[1].abs.round(2)
    direction
  end
  
end