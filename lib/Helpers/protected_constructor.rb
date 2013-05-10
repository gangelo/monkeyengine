module ProtectedConstructor
  def self.included(klass)
    klass.module_eval do
      class << self
        protected :new

        def inherited(klass)
          klass.module_eval do
            def self.new(*args); super; end
          end
        end
      end
    end
  end
end