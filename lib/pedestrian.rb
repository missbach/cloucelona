class Pedestrian < Unit
  
  def states
    [:normal, :canberobbed, :gettingrobbed]
  end
  
  def update_movement(dt)
    new_x = [[@pos.x, Game::SCREEN_SIZE.width - UNIT_RADIUS].min, UNIT_RADIUS].max
    @vel.x = -@vel.x if new_x != @pos.x
    
    new_y = [[@pos.y, Game::SCREEN_SIZE.height - UNIT_RADIUS].min, UNIT_RADIUS].max
    @vel.y = -@vel.y if new_y != @pos.y
  end
  
  attr_accessor :next_state
  
  def update(dt)
    self.current_state = self.next_state
    self.next_state = :normal
    super
  end

end