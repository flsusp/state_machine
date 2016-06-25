module StateMachine
  module Template
    def initialize
      raise InvalidState if !self.class.valid_state_machine?
      super
    end

    def valid_state_machine?
      !states.empty? && !@initial_state.nil?
    end

    def state(name, opts = { initial: false })
      raise MultipleStatesWithSameName if state_names.include? name
      state = StateMachine::State.new(name)
      states << state
      if opts[:initial]
        raise MultipleInitialStates unless @initial_state.nil?
        @initial_state = state
      end
    end

    def states
      @states = [] if @states.nil?
      @states
    end

    def state_names
      states.map { |state| state.name }
    end
  end
end
