require "observer"

module RockQueue
  class Notifiers
    include Observable 
    
    # Return the instance of notifiers registry.
    def self.instance
      @__instance__ ||= new
    end
    
    # Registers the observer. You have to pass the instance of your notifier.
    def register(instance)
      add_observer instance
    end
    
    # Notifies all the observers
    def notify(message)
      changed
      notify_observers message
    end
  end
end