class Object
  def context_tap(&block)
    self.instance_eval &block
    self
  end
  
  def try(symbol)
    super rescue nil
  end
end

class Numeric
  def sqrt
    Math.sqrt self
  end
end
