class Object
  def context_tap(&block)
    self.instance_eval &block
    self
  end
end