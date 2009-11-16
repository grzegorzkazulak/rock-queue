begin
  require "delayed_job"
rescue
  puts "You need `delayed_job` gem to use the Delayed Job rock-queue interface"
  exit
end

module RockQueue
  class DelayedJob
    
    attr_reader :obj
    
    def initialize(options = {})
    end
    
    def push(value, options)
      Delayed::Job.enqueue value
    end
  
    def receive
      loop
    end 
  end
end