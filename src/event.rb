module StateMachine
  class Event
    attr_reader :name, :transitions

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

    def assert_transitions(states)
      raise StateMachine::EventWithoutTransitions if @transitions.empty?
      @transitions.each do |transition|
        transition.assert_valid(states)
      end
    end
  end
end
