shared_examples_for "RockQueue adapter" do
  it "pushes a job" do
    @adapter.push(TestJob, 1).should_not be_nil
  end

  it "pops a job" do
    @adapter.push TestJob, 1
    @adapter.pop.should == [TestJob, [1]]
  end
end
