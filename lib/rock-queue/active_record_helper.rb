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
        RockQueue.push self, id, method, *args
      end
    end 
    
  end
end
