class Unit
  
  include Sprites::Sprite
  include EventHandler::HasEventHandler
  
  def initialize
    super
    
    @states = states.inject({}) { |states, state| states[state] = [tmp = Surface.load("./data/#{self.class.to_s.underscore}-#{state}.png"), tmp.make_rect]; states }
    
    setup_maths
    
    make_magic_hooks(ClockTicked => :update)
    apply_state
  end
  
  def requests_updates?
    true
  end
  
  def update(event)
    dt = event.seconds
    
    @vel.update update_vel_axis(@vel.x, @acc.x, dt), update_vel_axis(@vel.y, @acc.y, dt)
    @pos.update_relative *@vel.to_a.map { |z| z * dt }
    
    apply_state
  end
  
  protected
  
  def apply_state(state = nil)
    state ||= current_state
    @image, @rect = @states[state] if @prev_state != state
    @rect.center = @pos.to_a
    @prev_state = state
  end
  
  private
  
  def setup_maths
    @max_speed = 500
    @pos, @vel, @acc = Point.new(rand(24..776), rand(24..576)), Point.new(rand(-100..100), rand(-100..100)), Point.new
  end
 
  ## Muahahah!: copy and pasted from http://rubygame.org/wiki/Gradual_movement
  # 
  # Calculate the velocity for one axis.
  # v = current velocity on that axis (e.g. @vx)
  # a = current acceleration on that axis (e.g. @ax)
  #
  # Returns what the new velocity (@vx) should be.
  #
  def update_vel_axis( v, a, dt )
 
#    # Apply slowdown if not accelerating.
#    if a == 0
#      if v > 0
#        v -= @slowdown * dt
#        v = 0 if v < 0
#      elsif v < 0
#        v += @slowdown * dt
#        v = 0 if v > 0
#      end
#    end
 
    # Apply acceleration
    v += a * dt
 
    # Clamp speed so it doesn't go too fast.
    v = @max_speed if v > @max_speed
    v = -@max_speed if v < -@max_speed
 
    v
  end
  
end