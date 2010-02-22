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
        ActiveRecord::Base.verify_active_connections!
        @queue.receive do |queue|
          if queue
            begin
              # code that actually performs the action
              args = queue.args.first
              puts "=> Processing class #{queue.object.name} with params: #{args.inspect}"
              args.empty? ? queue.object.perform : queue.object.perform(args)
            rescue Object => e
              # Add failed processing and retry
              if queue.add_fail(e)
                sleep(queue.get_sleep_time)
                puts "=> Processing fail! Retrying #{queue.fails.length}"
                puts "   Message: #{e.message}"
                retry
              end
            end
          end
        end
      end
    end
 
  end
end