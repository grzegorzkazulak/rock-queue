module RockQueue
  class Notifiers
    
    # Return the instance
    def self.instance
      @__instance__ ||= new
    end
    
    def register(instance)
      
    end
  end
end