require 'rock-queue/beanstalkd'
require 'rock-queue/resque'

module RockQueue
  attr_reader :adapter
  
  class Base   
    def initialize(adapter, *options)
      case adapter
      when :beanstalkd
        @adapter = Beanstalkd.new(options)
      when :resque
        @adapter = Resque.new(options)
      end
    end
    
    def push(value, *options)
      @adapter.push(value, options)
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

