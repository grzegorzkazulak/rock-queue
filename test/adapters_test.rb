require File.dirname(__FILE__) + '/test_helper'

context "RockQueue::Adapters" do
  
  test "should be able to select existing adapter " do
    config = RockQueue::Config.settings
    assert_nothing_raised(Exception) { 
      @rq    = RockQueue::Base.new :resque, {:server => config.host, :port => config.port}
    }
    
  end
  
end