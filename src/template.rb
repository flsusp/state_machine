module StateMachine
  module Template
    def initialize
      raise InvalidState if !self.class.valid_state_machine?
      @states = self.class.states
      @current_state = self.class.initial_state

      def state?(state)
        @current_state == state
      end

      @states.each do |state|
        self.define_singleton_method("#{state}?".to_sym) do
          state = __method__.to_s.gsub(/\?/, '')
          state?(state.to_sym)
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

    def initial_state
      @initial_state
    end

    def states
      @states = [] if @states.nil?
      @states
    end
  end
end
