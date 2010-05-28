require File.dirname(__FILE__ ) + '/spec_helper'

describe "Worker" do
  before(:each) do
    RockQueue.setup :adapter => :resque,
                    :server  => 'localhost',
                    :port    => 6379
    RockQueue.clear
  end

  it "processes default queue when no is specified" do
    @worker = RockQueue::Worker.new
    @worker.queues.should == [:default]
  end

  it "works" do
    @worker = RockQueue::Worker.new(:default)
    post_mock = mock("Post")

    Post.stub!(:find).and_return(post_mock)
    RockQueue.push :default, Post, 1, :archive
    post_mock.should_receive(:archive)
    @worker.work(0)
  end

  it "should retry a failed job 3 times" do
    RockQueue.push :default, BadJob
    @worker = RockQueue::Worker.new(:default)
    @worker.work(0)
  end

  it "processes multiple jobs" do
    RockQueue.push :default, TestJob
    RockQueue.push :default, TestJob
    RockQueue.push :default, TestJob

    @worker = RockQueue::Worker.new(:default)
    @worker.work(0)
    RockQueue.size(:default).should == 0
  end

  it "works on multiple queues" do
    RockQueue.push :queue1, TestJob
    RockQueue.push :queue1, TestJob
    RockQueue.push :queue2, TestJob

    @worker = RockQueue::Worker.new(:queue1, :queue2)
    @worker.work(0)
    RockQueue.size(:queue1).should == 0
    RockQueue.size(:queue2).should == 0
  end

  it "works on all queues" do
    RockQueue.push :queue1, TestJob
    RockQueue.push :queue2, TestJob
    RockQueue.push :queue3, TestJob

    @worker = RockQueue::Worker.new("*")
    @worker.work(0)
    RockQueue.size(:queue1).should == 0
    RockQueue.size(:queue2).should == 0
    RockQueue.size(:queue3).should == 0
  end
end
