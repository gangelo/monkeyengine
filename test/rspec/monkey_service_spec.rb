require 'rspec'
require 'MonkeyService/monkey_service'


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
end