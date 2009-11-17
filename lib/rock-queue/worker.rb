module RockQueue
  class Worker
    # Whether the worker should log basic info to STDOUT
    attr_accessor :verbose
    
    # Initialize connection to queue server
    def initialize 
      @queue = RockQueue::Base.new RockQueue::Config.settings.adapter, {
        :server => RockQueue::Config.settings.host, 
        :port   => RockQueue::Config.settings.port
      }      
    end
    
    # Main worker loop where all jobs are beeing pulled of the queue. 
    # This is also a place where every job starts and ends it's lifecycle.
    def work
      loop do
        @queue.receive do |queue|
          if queue
            # code that actually performs the action
            begin
              p queue.class
              queue.object.perform
            rescue Object => e
              # Add failed processing and retry
              retry if queue.add_fail(e)
            end
          end
        end
      end
    end
 
  end
end