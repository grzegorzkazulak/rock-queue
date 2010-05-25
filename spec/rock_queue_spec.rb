require File.dirname(__FILE__) + '/spec_helper'

describe "RockQueue" do
  it "should setup Resque adapter" do
    RockQueue.setup :adapter => :resque,
                    :server => 'localhost',
                    :port => 6379
    RockQueue.adapter.kind_of? RockQueue::ResqueQueue
  end

  it "should setup Beanstalkd adapter" do
    RockQueue.setup :adapter => :beanstalkd,
                    :server => 'localhost',
                    :port => 11300
    RockQueue.adapter.kind_of? RockQueue::Beanstalkd
  end

  it "should setup DelayedJob adapter" do
    RockQueue.setup :adapter => :delayed_job
    RockQueue.adapter.kind_of? RockQueue::DelayedJob
  end

  it "should fail with unsupported adapter" do
    lambda {
      RockQueue.setup :adapter => :bad
    }.should raise_error
  end

  it "should fail whe not connected" do
    RockQueue.disconnect
    lambda { RockQueue.adapter }.should raise_error
  end
end
