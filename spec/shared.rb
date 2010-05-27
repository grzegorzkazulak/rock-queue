shared_examples_for "RockQueue adapter" do
  it "pushes a job" do
    @adapter.push(:default, TestJob, 1).should_not be_nil
  end

  it "pops a job" do
    @adapter.push(:default, TestJob, 1)
    @adapter.pop(:default).should == [TestJob, [1]]
  end

  it "returns number of jobs in queue" do
    @adapter.push(:queue1, TestJob, 1)
    @adapter.push(:queue1, TestJob, 2)
    @adapter.push(:queue2, TestJob, 3)

    @adapter.size(:queue1).should == 2
    @adapter.size(:queue2).should == 1
  end

  it "clears job queues" do
    @adapter.push(:queue1, TestJob, 1)
    @adapter.push(:queue1, TestJob, 2)
    @adapter.clear
    @adapter.queues.should == [:default]
  end

  it "always have default queue" do
    @adapter.clear
    @adapter.queues.should == [:default]
  end

  it "returns queue names" do
    @adapter.push(:queue1, TestJob, 1)
    @adapter.push(:queue2, TestJob, 2)
    @adapter.queues.should == [:default, :queue1, :queue2]
  end
end
