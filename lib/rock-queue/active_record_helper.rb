require 'active_record'

module RockQueue
  module ActiveRecordHelper
    def self.included(base) 
      base.extend ClassMethods 
      base.send(:include, InstanceMethods) 
    end
    
    module ClassMethods 
      def self.perform(id, method, *args)
        find(id).send(method, *args)
      end
    end 
    
    module InstanceMethods 
      def async(method, *args)
        rq = RockQueue::Base.new RockQueue::Config.settings.adapter, {:server => RockQueue::Config.settings.host, :port => RockQueue::Config.settings.port}
        rq.push self.class, id, method, *args
      end
    end 
    
  end
end
