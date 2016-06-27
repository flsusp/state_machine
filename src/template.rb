module StateMachine
  module Template
    def valid_state_machine?
      !states.empty? && !@initial_state.nil?
    end

    def state(state, opts = { initial: false })
      raise MultipleStatesWithSameName if states.include? state
      states << state
      if opts[:initial]
        raise MultipleInitialStates unless @initial_state.nil?
        @initial_state = state
      end
    end

    def event(event_name, &block)
      raise MultipleEventsWithSameName if event_names.include? event_name
      event = StateMachine::Event.new(event_name)
      yield(event) if block_given?
      event.assert_transitions
      events << event
    end

    def initial_state
      @initial_state
    end

    def states
      @states = [] if @states.nil?
      @states
    end

    def events
      @events = [] if @events.nil?
      @events
    end

    def event_names
      events.map { |event| event.name }
    end
  end
end
