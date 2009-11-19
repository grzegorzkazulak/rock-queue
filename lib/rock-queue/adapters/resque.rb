begin
  require 'resque'
rescue
  puts "You need `resque` gem to use the Resque rock-queue interface"
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

    # Retrieve item from Resque queue
    def pop
      job = Resque.reserve :default
      [job.payload_class, job.args] if job   
    end 
    
  end
end
