module RockQueue
  class Worker
    # Whether the worker should log basic info to STDOUT
    attr_accessor :verbose
    
    def initialize
      puts "=> Initializing..."
    end
    
    # Main worker loop where all jobs are beeing pulled of the queue. 
    # This is also a place where every job starts and ends it's lifecycle.
    def work
      puts "=> Worker ready. Hold your horses!"
      loop do
      end
    end
    
  end
end