require 'lib/rock-queue/beanstalkd'
require 'lib/rock-queue/resque'

module RockQueue
  attr_reader :adapter
  
  class Base   
    def initialize(adapter, *options)
      # Any better way to do this? :-)
      options = options.first
      if options.include?(:server) && options.include?(:port)
      case adapter
        when :beanstalkd
          @adapter = Beanstalkd.new(options)
        when :resque
          @adapter = ResqueQueue.new(options)
      end
      else
        raise ArgumentError
      end
    end
    
    def push(value, *options)
      @adapter.push(value, options)
    end
    
    def receive
      if block_given?
        begin 
          yield @adapter.receive
        rescue Object => e
          # failed
        else
          # job processed
        end
      end
    end
    
    def method_missing(sym, *args, &block)
       @adapter.send sym, *args, &block
    end
  end
end