begin
  require 'resque'
rescue
  puts "You need `resque` gem to use the Resque rock-queue interface"
  exit
end

module RockQueue
  class ResqueQueue
    
    attr_reader :obj
    
    def initialize(options)
      Resque.redis = "#{options[:server]}:#{options[:port]}"
    end
    
    def push(value, options)
      if !defined?(value.queue)
        value.class_eval do 
          @queue = :default
        end
      end
      Resque.enqueue value
    end
  
    def pop
      job = Resque.reserve :default
      if job
        job.payload_class
      end
    end 
  end
end
