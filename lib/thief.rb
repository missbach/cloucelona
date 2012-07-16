class Thief < Unit
  
  include KeyboardControlled
  
  def potential_victims
    Game.inst.units.select { |unit| unit != self && position.distance_to(unit.position) < THIEF_RADIUS }
  end
  
  def update(dt)
    next_state = @keys.include?(:space) ? :robbing : :normal
    potential_victims.tap do |victims|
      victims = @current_victims & victims unless @current_victims.nil?
      victim_state = next_state == :robbing ? :gettingrobbed : :canberobbed
      victims.each { |victim| victim.next_state = victim_state }
      @current_victims = (current_state = next_state) == :normal ? nil : victims
    end
    super
  end
  
end