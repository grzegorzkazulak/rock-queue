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
      Resque.enqueue value
    end
  
    def receive
      loop
    end 
  end
end
