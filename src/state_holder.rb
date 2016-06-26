module StateMachine
  class StateHolder
    attr_reader :state

    def initialize(state)
      @state = state
    end
  end
end
