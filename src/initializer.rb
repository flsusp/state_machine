module StateMachine
  module Initializer
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
  end
end
