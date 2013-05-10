require 'rspec'
require 'MonkeyFactory/monkey_factory'

describe 'MonkeyFactory' do

  before(:all) do
  end

  after(:all) do
  end

  context 'create' do

    it 'should instantiate an object from the factory' do
      monkey = MonkeyFactory::create(:harpo)
      monkey.nil?.should == false
      monkey.is_a?(Monkey).should == true
    end

    it 'should not instantiate an object without using the factory' do
      lambda { Monkey.new :groucho }.should raise_error NoMethodError
    end
  end
end