class Vector
  
  attr_accessor :x, :y
  
  def to_a
    [x, y]    
  end

  def initialize(*args)
    update *args
  end
  
  def update(x = 0, y = 0)
    self.x = x
    self.y = y
  end
  
  def update_relative(x = 0, y = 0)
    self.x += x
    self.y += y
  end
  
  def ensure_inside(x, y)
    self.x = ensure_inside_axis(self.x, x.try(:first) || 0, x.try(:last) || x)
    self.y = ensure_inside_axis(self.y, y.try(:first) || 0, y.try(:last) || y)
  end
  
  def self.[](*args)
    new *args
  end
  
  private
  def ensure_inside_axis(x, min, max)
    x < min ? min : x > max ? max : x
  end
  
end