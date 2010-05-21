require File.dirname(__FILE__) + '/spec_helper'

describe "QueueObject" do
  before(:each) do
    @qo = RockQueue::QueueObject.new(nil, [])
  end

  it "should have no fails" do
    @qo.fails.should be_empty
  end

  it "returns 1 as sleep time" do
    @qo.get_sleep_time.should == 1
  end

  describe "after 2 fails" do
    before(:each) do
      2.times { @qo.add_fail Exception.new("Failure") }
    end

    it "returns 4 as sleep time" do
      @qo.get_sleep_time.should == 4
    end

    it "sends a notification after another fail" do
      notifiers_mock = mock("Notifiers")
      notifiers_mock.should_receive(:notify)
      RockQueue::Notifiers.stub(:instance).and_return(notifiers_mock)
      @qo.add_fail Exception.new("Failure")
    end
  end
end
