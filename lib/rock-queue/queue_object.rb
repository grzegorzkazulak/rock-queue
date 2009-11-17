# Queue object wrapper
class QueueObject
  
  attr_reader :object, :fails
  
  def initialize(object)
    @object = object
    @fails = Array.new
  end

  # Add processing fail
  def add_fail(exception)
    RockQueue::Notifiers.instance.notify(exception)
    @fails << exception
    @fails.length == 3
  end

  # Get sleep time after fail
  def get_sleep_time
    2 ** ( @fails.length + 1 )
  end
  
end
