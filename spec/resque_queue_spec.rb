require File.dirname(__FILE__) + '/spec_helper'

describe "ResqueQueue" do
  before(:each) do
    @adapter = RockQueue::ResqueQueue.new(:server => 'localhost', :port => 6379)
    @adapter.clear
  end

  it "pushes a job" do
    @adapter.push TestJob, 1
    @adapter.pop.should == [TestJob, [1]]
  end
end
