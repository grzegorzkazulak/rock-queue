module RockQueue
  class Worker
    # Whether the worker should log basic info to STDOUT
    attr_accessor :verbose
    
    # Initialize connection to queue server
    def initialize 
      puts "=> Initializing..."
      config = RockQueue::Config.settings
      @queue = RockQueue::Base.new config.adapter, {
        :server => config.host, 
        :port   => config.port
      }      
    end
    
    # Main worker loop where all jobs are beeing pulled of the queue. 
    # This is also a place where every job starts and ends it's lifecycle.
    def work
      puts "=> Worker ready. Hold your horses!"
      loop do
        @queue.receive do |queue|
          if queue
            # code that actually performs the action
            begin
              args = queue.args.first
              queue.object.perform(args[0], args[1], args)
            rescue Object => e
              # Add failed processing and retry
              if queue.add_fail(e)
                sleep(queue.get_sleep_time)
                puts "=> Processing fail! Retrying #{queue.fails.length}"
                retry
              end
            end
          end
        end
      end
    end
 
  end
end