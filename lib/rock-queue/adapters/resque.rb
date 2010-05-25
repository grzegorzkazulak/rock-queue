begin
  require 'resque'
rescue
  RockQueue::Base.logger.error "You need `resque` gem to use the Resque rock-queue interface"
  exit
end

module RockQueue
  class ResqueQueue
    
    attr_reader :obj
    
    # Contructor of Resque adapter
    def initialize(options)
      Resque.redis = "#{options[:server]}:#{options[:port]}"
    end
    
    # Push item from Resque queue
    def push(value, args)
      if !defined?(value.queue)
        value.class_eval do 
          @queue = :default
        end
      end
      Resque.enqueue value, args
    end
    
    # Push items to Resque queue to be picked up by the worker on specified time
    def push_at(value, time_to_run_at ,*args)
      if !defined?(value.queue)
        value.class_eval do 
          @queue = :default
        end
      end
      Resque.enqueue_at time_to_run_at, value, args
    end    

    # Retrieve item from Resque queue
    def pop
      job = Resque.reserve :default
      [job.payload_class, job.args] if job   
    end 
    
    # Register worker for web interface
    def register_worker(worker)
      Resque.redis.sadd(:workers, worker)
    end    
    
    def clear
      Resque.redis.flushall
    end
  end
end
