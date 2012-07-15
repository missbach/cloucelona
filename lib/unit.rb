class Unit
  
  include Sprites::Sprite
  
  def initialize
    super
    
    @image = Surface.load "data/#{self.class.to_s.underscore}.png"
    @rect  = @image.make_rect
    
  end
  
end