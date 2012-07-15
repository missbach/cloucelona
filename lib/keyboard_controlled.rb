module KeyboardControlled
  
  def initialize(*args)
    super.tap do
      @keys ||= []
      make_magic_hooks(KeyPressed => :key_pressed, KeyReleased => :key_released)
    end
  end
  
  def key_pressed(event)
    @keys += [event.key]
  end
  
  def key_released(event)
    @keys -= [event.key]
  end
  
  ## Muahahah!: copy and pasted from http://rubygame.org/wiki/Gradual_movement
  ##            (modified)
  def update_movement(dt)
    x, y = 0, 0
 
    x -= 1 if @keys.include?( :left )
    x += 1 if @keys.include?( :right )
    y -= 1 if @keys.include?( :up ) # up is down in screen coordinates
    y += 1 if @keys.include?( :down )
 
    x *= @max_acceleration
    y *= @max_acceleration
 
    @acc.update x, y
  end
  
  def slowdown?
    true
  end
  
end