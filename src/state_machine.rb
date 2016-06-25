module StateMachine

  class InvalidState < StandardError; end

  def StateMachine.state(name)
  end

  def self.included(o)
    o.extend(ClassMethods)
    o.send :prepend, Initializer
  end

  module Initializer
    def initialize
      raise InvalidState
      super
    end
  end

  module ClassMethods
    def valid_state_machine?
    end

    def state(name)
    end
  end
end
