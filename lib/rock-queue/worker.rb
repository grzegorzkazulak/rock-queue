module RockQueue
  class Worker
    # Whether the worker should log basic info to STDOUT
    attr_accessor :verbose
    
    # Initialize connection to queue server
    def initialize(*queues)
      queues = [:default] if queues.size == 0
      @queues = queues
      RockQueue.logger.info "=> Initializing..."
    end
    
    # Main worker loop where all jobs are beeing pulled of the queue. 
    # This is also a place where every job starts and ends it's lifecycle.
    def work(interval = 5)
      RockQueue.logger.info "=> Worker ready. Hold your horses!"
      stop = false
      loop do
        sleep(interval)
        
        ActiveRecord::Base.verify_active_connections!
        queues.each do |qname|
          obj, args = RockQueue.pop(qname)
          if obj
            queue = QueueObject.new(obj, args)
            begin
              # code that actually performs the action
              args = queue.args.first
              RockQueue.logger.info "=> Processing class #{queue.object.name} with params: #{args.inspect}"
              args.empty? ? queue.object.perform : queue.object.perform(args)
            rescue Object => e
              # Add failed processing and retry
              if queue.add_fail(e)
                sleep(queue.get_sleep_time)
                RockQueue.logger.error "=> Processing fail! Retrying #{queue.fails.length}"
                RockQueue.logger.error "   Message: #{e.message}"
                retry
              end
            end
            stop = false
          else
            stop = true if interval == 0
          end
        end
        break if stop
      end
    end

    # Returns a list of queues
    # A single '*' means all queues
    def queues
      @queues[0] == "*" ? RockQueue.queues : @queues
    end
  end
end
