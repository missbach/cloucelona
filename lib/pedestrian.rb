class Pedestrian < Unit
  
  def states
    [:normal, :canberobbed, :gettingrobbed]
  end
  
  def current_state
    :normal
  end
  
end