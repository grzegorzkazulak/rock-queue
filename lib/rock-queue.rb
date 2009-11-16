$:.unshift File.expand_path(File.dirname(__FILE__))

module RockQueue

  autoload :Config,                   'rock-queue/config'
  autoload :Worker,                   'rock-queue/worker'
  
  # Adapters
  autoload :Beanstalkd,               'rock-queue/adapters/beanstalkd'
  autoload :ResqueQueue,              'rock-queue/adapters/resque'
  autoload :DelayedJob,               'rock-queue/adapters/delayed_job'
  
  autoload :AdapterNotSupported,      'rock-queue/errors'
  autoload :NoClassError,             'rock-queue/errors'
  autoload :QueueingServerNotRunning, 'rock-queue/errors'
  autoload :ActiveRecordHelper,       'rock-queue/active_record_helper'
  
  attr_reader :adapter
  
  class Base   
    
    # Initializes the whole thing and makes the connection to the 
    # queueing server using selected adapter (passed as lowercased symbol)
    def initialize(adapter, *options)
      
      # Any better way to do this? :-)
      options = options.first
      if options.include?(:server) && options.include?(:port)
      case adapter
        when :beanstalkd
          @adapter = Beanstalkd.new(options)
        when :resque
          @adapter = ResqueQueue.new(options)
        when :delayed_job
          @adapter = DelayedJob.new(options)
      end
      else
        raise ArgumentError
      end
    end
    
    # Pushes the value (in our case it should always be an object)
    # onto the queue using previously selected adapter
    def push(value, *options)
      @adapter.push(value, options)
    end
    
    # Pulls the data off the queue. There are two ways to do so:
    # - Call receive with no block (gets you a single item)
    # - Pass a block to it (creates and endles loop that constantly pulls items from the queue as they become available)
    # All calls to the queueing server are made through the previosuly selected adaper.
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
