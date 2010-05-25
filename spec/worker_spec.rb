require File.dirname(__FILE__ ) + '/spec_helper'

describe "Worker" do
  before(:each) do
    RockQueue.setup :adapter => :resque,
                    :server  => 'localhost',
                    :port    => 6379
    @worker = RockQueue::Worker.new
  end

  it "works" do
    post_mock = mock("Post")

    Post.stub!(:find).and_return(post_mock)
    RockQueue.push Post, 1, :archive
    post_mock.should_receive(:archive)
    @worker.work(0)
  end
end
