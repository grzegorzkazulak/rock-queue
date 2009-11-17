# Queue object wrapper
class QueueObject
  
  attr_reader :object, :fails
  
  def initialize(object)
    @object = object
    @fails = Array.new
  end

  # Add processing fail
  def add_fail(exception)
    @fails << exception
    @fails.length <= 3
  end
  
end
