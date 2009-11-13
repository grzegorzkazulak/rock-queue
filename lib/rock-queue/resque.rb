# begin
#   require "beanstalk-client"
# rescue
#   puts "You need `beanstalk-client` gem to use the Beanstalkd rock-queue interface"
#   exit
# end

module RockQueue
  class Resque
    
    attr_reader :obj
    
    def initialize(options = {})
      redis = {:host => "venus.dnc.pl", :port => 9999, :thread_safe => true}
    end
    
    def push(value, queue = 'default', options = {})
      push(queue, value)
    end
  
    def receive
      loop
    end 
  end
end