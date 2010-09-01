require File.dirname(__FILE__) + '/spec_helper'

describe "EmailNotifier" do
  before do
    config = {
      :from => "joe@localhost",
      :to   => "mike@localhost"
    }
    @notifier = RockQueue::EmailNotifier.new(config)

    Mail.defaults do
      delivery_method :test
    end
  end

  it "sends an email" do
    err = nil
    begin
      raise Exception, "Failure"
    rescue Exception => e
      err = e
    end
    @notifier.update(err)
    email = Mail::TestMailer.deliveries.first
    email.subject.should == "Processing error - 'Failure'"
  end
end
