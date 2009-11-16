module RockQueue
  class Config
    
    attr_accessor :adapter, :host, :port
    
    # Return the instance
    def self.instance
      @__instance__ ||= new
    end

    # Yields a singleton instance of RockQueue::Config so you can specify config
    # information like server address, port etc.
    def self.settings
      if block_given?
        yield self.instance
      else
        self.instance
      end
    end
    
  end
end