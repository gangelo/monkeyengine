# frozen_string_literal: true

require 'MonkeyFactory'

describe 'MonkeyFactory' do
  context 'create' do
    it 'instantiates an object from the factory' do
      MonkeyFactory.create(:harpo).is_a?(Monkey).should be true
    end

    it 'does not instantiate an object without using the factory' do
      -> { Monkey.new :groucho }.should raise_error NoMethodError
    end
  end
end
