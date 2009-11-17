module RockQueue
  class Notifiers
    include Observable 
    
    def register(instance)
      add_observer instance
    end
    
    def self.notify(message)
      notify_observers message
      p "lkiu"
    end
  end
end