# frozen_string_literal: true

# Shared for monkey action.
shared_examples_for 'MonkeyAction' do
  it 'has read access to monkey' do
    @it.respond_to?(:monkey).should be true
  end

  it 'does not have write access to monkey' do
    @it.respond_to?(:monkey=).should_not == true
  end

  it_behaves_like 'Action'
end

# Action
shared_examples_for 'Action' do
  it 'respond_to?s :value' do
    # "Value: #{@it.value}"
    @it.respond_to?(:value).should be true
  end

  it 'respond_to?s :weight' do
    # "Weight: #{@it.weight}"
    @it.respond_to?(:weight).should be true
  end

  # value
  it '@value should not be nil?' do
    @it.value.nil?.should_not == true
  end

  # weight
  it '@weight should not be nil?' do
    @it.weight.nil?.should_not == true
  end

  it '@weight should be is_a? Float' do
    @it.weight.is_a?(Float).should be true
  end
end
