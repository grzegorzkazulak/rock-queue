begin
  require "beanstalk-client"
rescue
  RockQueue.logger.error "You need `beanstalk-client` gem to use" \
                         "the Beanstalkd rock-queue interface"
  exit
end

module RockQueue
  class Beanstalkd
    attr_reader :obj
    
    def initialize(options = {})
      @options = options
      @addr = "#{options[:server]}:#{options[:port]}"
      @obj = Beanstalk::Pool.new([@addr])
    end
  
    def push(queue, value, *args)
      @obj.send(:send_to_rand_conn, :use, queue)
      @obj.put [value.name, args].to_yaml 
    end

    def pop(queue)
      @obj.send(:send_to_rand_conn, :use, queue)
      r = YAML.load(@obj.reserve.body)
      r[0] = Kernel.const_get(r[0])
      r
    end 

    def clear
      kill_cmd = `which killall`.empty? ? "pkill" : "killall"
      
      system "#{kill_cmd} beanstalkd"
      system "beanstalkd -d -p #{@options[:port]}"
    end

    def size(queue)
      @obj.stats_tube(queue)["current-jobs-ready"]
    end

    def queues
      @obj.list_tubes[@addr].map(&:to_sym)
    end
  end
end
