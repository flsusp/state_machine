module StateMachine
  class InvalidState < StandardError; end
  class MultipleInitialStates < StandardError; end
  class MultipleStatesWithSameName < StandardError; end

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

  def self.included(o)
    o.extend(Template)
    o.send :prepend, Template
  end

  class State
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end
