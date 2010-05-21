require File.dirname(__FILE__) + '/spec_helper'

describe "Beanstalkd" do
  before(:each) do
    @adapter = RockQueue::Beanstalkd.new(:server => 'localhost', :port => 11300)
    @adapter.clear
  end

  it_should_behave_like "RockQueue adapter"
end
