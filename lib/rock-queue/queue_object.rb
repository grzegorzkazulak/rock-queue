module RockQueue

  # Queue object wrapper
  class QueueObject
    
    DEFAULT_FAIL_LIMIT = 3
    
    attr_reader :object, :args, :fails
    
    # Constructor of queue objects wrapper
    def initialize(object, args)
      @object = object
      @args   = args
      @fails  = Array.new
    end
  
    # Add processing fail
    def add_fail(exception)
      @fails << exception
      if @fails.length < DEFAULT_FAIL_LIMIT
        return true
      else
        RockQueue::Notifiers.instance.notify(exception)
      end
    end
  
    # Get sleep time after fail
    def get_sleep_time
      2 ** @fails.length
    end
    
  end

end