module StateMachine
  module Template
    def initialize
      raise InvalidState if !self.class.valid_state_machine?
      @states = self.class.states
      @current_state = self.class.initial_state
      @events = self.class.events

      def state?(state)
        @current_state == state
      end

      def current_state
        @current_state
      end

      @states.each do |state|
        self.define_singleton_method("#{state}?".to_sym) do
          state = __method__.to_s.gsub(/\?/, '')
          state?(state.to_sym)
        end
      end

      @events.each do |event|
        self.define_singleton_method(event.name.to_sym) do
          transition = event.get_transition_from(@current_state)
          raise InvalidStateTransition if transition.nil?
          @current_state = transition.execute
        end
      end

      super
    end

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
      yield(event)
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
