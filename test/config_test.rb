require File.dirname(__FILE__) + '/test_helper'

context "RockQueue::Config" do
  
  setup do
    @config = RockQueue::Config.new
  end
  
  test "should return notifiers instance " do  
    assert_instance_of(RockQueue::Config, @config)
    assert_instance_of(RockQueue::Notifiers, @config.notifiers)
  end
  
  test "should return settings/self instance" do
    assert_instance_of(RockQueue::Config, @config)
    assert_instance_of(RockQueue::Config, RockQueue::Config.settings)
  end
  
end