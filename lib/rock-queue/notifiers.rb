require "observer"

module RockQueue
  class Notifiers
    include Observable 
    
    def self.instance
      @__instance__ ||= new
    end
    
    def register(instance)
      add_observer instance
    end
    
    def notify(message)
      changed
      notify_observers message
    end
  end
end