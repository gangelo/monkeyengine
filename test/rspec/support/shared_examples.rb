# Shared for monkey action.
shared_examples_for "MonkeyAction" do
  it "should have read access to monkey" do
    @it.respond_to?(:monkey).should == true
  end

  it "should not have write access to monkey" do
    @it.respond_to?(:monkey=).should_not == true
  end

  it_should_behave_like "Action"
end

# Action
shared_examples_for "Action" do

  it "should respond_to? :value" do
    # "Value: #{@it.value}"
    @it.respond_to?(:value).should == true
  end

  it "should respond_to? :weight" do
    # "Weight: #{@it.weight}"
    @it.respond_to?(:weight).should == true
  end

  # value
  it "@value should not be nil?" do
    @it.value.nil?.should_not == true
  end

  # weight
  it "@weight should not be nil?" do
    @it.weight.nil?.should_not == true
  end

  it "@weight should be is_a? Float" do
    @it.weight.is_a?(Float).should == true
  end
end

