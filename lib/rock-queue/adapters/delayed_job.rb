begin
  require "delayed_job"
rescue
  RockQueue.logger.error "You need `delayed_job` gem to use" \
                         "the Delayed Job rock-queue interface"
  exit
end

module RockQueue
  class DelayedJob
    attr_reader :obj
    
    def initialize(options = {})
    end
    
    def push(klass, options)
      Delayed::Job.enqueue klass
    end
  
    def pop
    end 
  end
end
