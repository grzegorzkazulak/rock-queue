module RockQueue

  # Queue object wrapper
  class QueueObject
    
    DEFAULT_FAIL_LIMIT = 3
    
    attr_reader :object, :fails
    
    def initialize(object)
      @object = object
      @fails = Array.new
      config = RockQueue::Config.settings
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