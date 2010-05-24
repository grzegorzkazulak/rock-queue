require File.dirname(__FILE__) + '/spec_helper'

RockQueue::Config.settings do |config|
  config.adapter = :resque
  config.host = 'localhost'
  config.port = '6379'
end

describe "Object with ActiveRecordHelper" do
  before(:each) do
    @post = Post.create(:title => "Test")
  end

  it "class responds to .perform" do
    @post.class.perform([@post.id, :title]).should == "Test"
  end

  it "calls a method asynchronously" do
    @post.async(:archive)
    rq = @post.instance_variable_get(:@rq)
    rq.pop.should == [Post, [[@post.id, "archive"]]]
  end
end
