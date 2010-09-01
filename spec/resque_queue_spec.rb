require File.dirname(__FILE__) + '/spec_helper'

RockQueue.setup(
  :adapter => :resque,
  :server  => 'localhost',
  :port    => 6379
)

describe "ResqueQueue" do
  before(:each) do
    @adapter = RockQueue::ResqueQueue.new(:server => 'localhost', :port => 6379)
    @adapter.clear
  end

  it_should_behave_like "RockQueue adapter"
  
  it "should register worker" do
    worker = RockQueue::Worker.new(:default)
    @adapter.register_worker(worker)
    Resque.redis.sismember(:workers, worker).should == true
  end
end
