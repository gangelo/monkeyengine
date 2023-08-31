# frozen_string_literal: true

require 'MonkeyService'
require 'MonkeyFactory'
require 'MonkeyEngine'

describe 'MonkeyService' do
  before(:all) do
    @it = MonkeyEngine::MonkeyService.instance

    # Register us before we do anything, so we can be notified of everything.
    @it.add_observer self

    @it.add(MonkeyFactory.create(:groucho))
    @it.add(MonkeyFactory.create(:harpo))
    @it.add(MonkeyFactory.create(:chico))
  end

  after(:all) do
    # Kill all the threads.
    @it.kill_all!

    # Give them a little bit to finish.
    @it.join_all(10)
  end

  def update(time, action, _param)
    # puts "Time: [#{time}], Action: [#{action}], Param: [#{param}]"
    puts "Time: [#{time}], Action: [#{action}], Param: <not shown>"
  end

  context 'initialization' do
    it 'has 3 monkeys' do
      @it.count.should == 3
    end

    it 'has monkey harpo' do
      @it.exists?(:harpo).should be true
    end

    it 'has monkey groucho' do
      @it.exists?(:groucho).should be true
    end

    it 'has monkey chico' do
      @it.exists?(:chico).should be true
    end
  end

  context 'methods' do
    it "'get' should raise an exception if invalid argument type is sent" do
      -> { @it.get(999) }.should raise_exception MonkeyEngine::Exceptions::InvalidArgumentTypeException
    end

    it "'add' should raise an exception if adding a non-unique object" do
      lambda {
        @it.add(MonkeyFactory.create(:chico))
      }.should raise_exception MonkeyEngine::Exceptions::UniqueObjectException
    end

    it "'any_alive?' should return objects that are alive" do
      @it.any_alive?.should be true
    end
  end

  context 'clean up' do
    it 'no monkeys should be alive if killed by the service' do
      # Kill all the threads.
      @it.kill_all!

      # Give them a little bit to finish.
      @it.join_all(10)

      @it.any_alive?.should be false
    end

    it 'kill_all! should return all monkeys killed' do
      monkey_service = MonkeyEngine::MonkeyService.instance

      monkey_service.add(MonkeyFactory.create(:a))
      monkey_service.add(MonkeyFactory.create(:b))
      monkey_service.add(MonkeyFactory.create(:c))

      monkeys = monkey_service.get_all

      killed_monkeys = monkey_service.kill_all!

      monkey_service.join_all(10)

      (monkeys == killed_monkeys).should be true
    end
  end
end
