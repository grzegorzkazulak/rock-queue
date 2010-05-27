require File.dirname(__FILE__) + '/spec_helper'

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

  it "calls a method asynchronously" do
    @post.async(:archive)
    RockQueue.pop(:default).should == [Post, [[@post.id, "archive"]]]
  end
end
