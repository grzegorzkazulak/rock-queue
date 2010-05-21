begin
  require "beanstalk-client"
rescue
  RockQueue::Base.logger.error "You need `beanstalk-client` gem to use the Beanstalkd rock-queue interface"
  exit
end

module RockQueue
  class Beanstalkd
    
    attr_reader :obj
    
    def initialize(options = {})
      @obj = Beanstalk::Pool.new(["#{options[:server]}:#{options[:port]}"])
    end
  
    def push(value, *args)
      @obj.put [value.name, args].to_yaml 
    end

    def pop
      r = YAML.load(@obj.reserve.body)
      r[0] = Kernel.const_get(r[0])
      r
    end 

    def clear
    end
  end
end
