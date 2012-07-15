class Pedestrian < Unit
  
  def states
    [:normal, :canberobbed, :gettingrobbed]
  end
  
  def update_movement(dt)
    # TODO: remove hard-coded magic numbers
    # Invert direction if outside of field and put inside field 
    if @pos.x > 776
      @pos.x = 776
      @vel.x = - @vel.x
    elsif @pos.x < 24
      @pos.x = 24
      @vel.x = - @vel.x
    end
    if @pos.y > 576
      @pos.y = 576
      @vel.y = - @vel.y
    elsif @pos.y < 24
      @pos.y = 24
      @vel.y = - @vel.y
    end
  end

end