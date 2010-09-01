require File.dirname(__FILE__) + '/spec_helper'
require 'resque_scheduler'

RockQueue.setup(
  :adapter => :resque,
  :server  => 'localhost',
  :port    => 6379
)

describe "Object with ActiveRecordHelper" do
  before(:each) do
    @post = Post.create(:title => "Test")
    RockQueue.clear
  end

  it "class responds to .perform" do
    @post.class.perform([@post.id, :title]).should == "Test"
  end
  
  it "should respond to queue" do
    @post.class.queue.should == :default
  end

  it "calls a method asynchronously" do
    @post.async(:archive)
    RockQueue.pop(:default).should == [Post, [[@post.id, "archive"]]]
  end
  
  it "calls a method asynchronously at a given time" do
    time = Time.now.to_i + 3600
    
    Resque.delayed_queue_schedule_size.should == 0
    @post.async_at(:archive, time)
    
    Resque.delayed_queue_schedule_size.should == 1
    Resque.next_item_for_timestamp(time).should == {
      "args"  => [[@post.id, "archive"]],
      "class" => "Post",
      "queue" => "default"
    }
  end
end
