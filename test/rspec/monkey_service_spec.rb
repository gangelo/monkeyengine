require 'rspec'
require 'MonkeyService/monkey_service'
require 'MonkeyEngine/exceptions'


describe 'MonkeyService' do

  before(:all) do
    @it = MonkeyEngine::MonkeyService.instance
  end

  after(:all) do
    # Kill all the threads.
    @it.kill_all

    # Give them a little bit to finish.
    @it.join_all(10)
  end

  context 'initialization' do

    it 'it should have 3 monkeys' do
      @it.count.should == 3
    end

    it 'should have monkey harpo' do
      @it.exists?(:harpo).should == true
    end

    it 'should have monkey groucho' do
      @it.exists?(:groucho).should == true
    end

    it 'should have monkey chico' do
      @it.exists?(:chico).should == true
    end

  end

  context 'methods' do

    it "'get' should raise an exception if invalid argument type is sent" do
      lambda { @it.get(999) }.should raise_exception MonkeyEngine::Exceptions::InvalidArgumentTypeException
    end

  end

  context 'clean up' do

    it 'no monkeys should be alive if killed by the service' do
      # Kill all the threads.
      @it.kill_all!

      # Give them a little bit to finish.
      @it.join_all(10)

      @it.any_alive?.should == false
    end

  end

end