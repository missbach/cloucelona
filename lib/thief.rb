class Thief < Unit
  
  include KeyboardControlled
  
  def potential_victims
    Game.inst.units.select { |unit| unit != self && position.distance_to(unit.position) < THIEF_RADIUS }
  end
  
  def update(dt)
    next_state = @keys.include?(:space) ? :robbing : :normal
    potential_victims.tap do |victims|
      @victims = next_state == :robbing && current_state != :robbing ? victims : @victims & victims
      victim_state = next_state == :robbing ? :gettingrobbed : :canberobbed
      victims.each { |victim| victim.next_state = victim_state }
    end
    current_state = next_state
    super
  end
  
end