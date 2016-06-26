module StateMachine
  class Event
    attr_reader :name

    def initialize(name)
      @name = name
      @transitions = []
    end

    def from(from, to: nil, &block)
      @transitions << StateMachine::Transition.new(from, to, &block)
    end

    def get_transition_from(from)
      @transitions.find { |transition| transition.from == from }
    end
  end
end
