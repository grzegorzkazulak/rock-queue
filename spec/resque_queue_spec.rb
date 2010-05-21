require File.dirname(__FILE__) + '/spec_helper'

describe "ResqueQueue" do
  before(:each) do
    @adapter = RockQueue::ResqueQueue.new(:server => 'localhost', :port => 6379)
    @adapter.clear
  end

  it_should_behave_like "RockQueue adapter"
end
