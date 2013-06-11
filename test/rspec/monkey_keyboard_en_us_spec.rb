require 'rspec'
require 'MonkeyKeyboard/monkey_keyboard_en_us'

describe 'MonkeyKeyboardEnUs' do

  before (:all) do
    @it = MonkeyEngine::MonkeyKeyboardEnUs.instance
  end

  after (:all) do
  end

  context 'keys' do
    pending 'Test this'
  end

  context 'left_keys' do

    it 'should have the right left keys' do
      @it.left_keys

      true.should == false
    end

  end

  context 'right_keys' do
    pending 'Test this'
  end

end