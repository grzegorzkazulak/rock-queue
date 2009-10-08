require 'rock-queue/beanstalkd'

module RockQueue
  attr_reader :adapter
  
  class Base   
    def initialize(adapter, *options)
      case adapter
      when :beanstalkd
        @adapter = Beanstalkd.new(options)
      end
    end
    
    def put(value, *options)
      raise ArgumentError
    end
    
    def receive
      if block_given?
        yield @adapter.receive
      end
    end
    
    def method_missing(sym, *args, &block)
       @adapter.send sym, *args, &block
    end
  end
end

