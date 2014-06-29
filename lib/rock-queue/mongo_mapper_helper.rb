module RockQueue
  
  # Right now the MongoMapper helper is a mirror image of the ActiveRecord
  # helper. Including it simply included the ActiveRecord one
  module MongoMapperHelper
    def self.included(base) 
      base.extend RockQueue::ActiveRecordHelper::ClassMethods 
      base.send(:include, RockQueue::ActiveRecordHelper::InstanceMethods)
    end 
  end
end
