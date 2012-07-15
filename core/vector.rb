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
  
  def self.[](*args)
    new *args
  end
  
end