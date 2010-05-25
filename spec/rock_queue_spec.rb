require File.dirname(__FILE__) + '/spec_helper'

describe "RockQueue" do
  it "should setup" do
    RockQueue.setup :adapter => :resque, :server => 'localhost', :port => 6379
    RockQueue.adapter.kind_of? RockQueue::ResqueQueue
  end
end
