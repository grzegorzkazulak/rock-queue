module RockQueue
  class Notifiers
    
    # Return the instance
    def self.instance
      @__instance__ ||= new
    end
    
    # Return registered notifiers
    def self.available
      @@_notifiers ||= []
      @@_notifiers
    end
    
    def register(instance)
      self.available << instance
    end
    
    def notify(message)
      self.available.each do |notifier|
        notifier.notify(message)
      end
    end
  end
end