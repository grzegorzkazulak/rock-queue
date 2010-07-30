require File.dirname(__FILE__) + '/spec_helper'

require "mail"

describe "Notifiers" do
  it "registers an observer" do
    notifiers = RockQueue::Notifiers.instance
    notifier  = RockQueue::EmailNotifier.new({:from => "joe@localhost", :to   => "mike@localhost"})
    
    notifiers.count_observers.should == 0
    notifiers.register(notifier)
    notifiers.count_observers.should == 1
    notifiers.delete_observers
  end
end
