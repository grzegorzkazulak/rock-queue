require File.dirname(__FILE__) + '/test_helper'

context "RockQueue::Worker" do
  
  # configure the adapter properly
  setup do
    config = RockQueue::Config.settings
    @rq    = RockQueue::Base.new config.adapter, {:server => config.host, :port => config.port}
  end
  
  test "so it knows when it is working" do
  end
  
  test "fail when no block given to receive method" do
    assert_raise(RuntimeError) { @rq.receive }
  end
  
  test "not fail when block given" do
    assert_nothing_raised(Exception) { 
      @rq.receive do |item|
        item
      end
    }
  end
  
end