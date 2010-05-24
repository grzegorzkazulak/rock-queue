require File.dirname(__FILE__ ) + '/spec_helper'

describe "Worker" do
  before(:each) do
    @rq = RockQueue::Base.new :resque, :server => 'localhost', :port => 6379
    @worker = RockQueue::Worker.new
  end

  it "works" do
    post_mock = mock("Post")

    Post.stub!(:find).and_return(post_mock)
    @rq.push Post, 1, :archive
    mock.should_recieve(:archive)
    @worker.work(0)
  end
end
