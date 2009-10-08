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
    send
  end
end

require 'rock-queue'
rq = RockQueue::Base.new :beanstalkd, ['localhost:11300']
# 
# rq.receive do |queue_object|
#    puts queue_object.message
# end