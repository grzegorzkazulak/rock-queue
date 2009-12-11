require 'active_record'

module RockQueue
  module ActiveRecordHelper
    def self.included(base) 
      base.extend ClassMethods 
      base.send(:include, InstanceMethods) 
    end
    
    module ClassMethods
      def perform(*args)
        args = args.first
        id = args.shift
        method = args.shift
        find(id).send(method, *args)
      end
    end
    
    module InstanceMethods 
      def async(method, *args)
        config = RockQueue::Config.settings
        rq = RockQueue::Base.new config.adapter, {:server => config.host, :port => config.port}
        rq.push self.class, id, method, *args
      end
    end 
    
  end
end
