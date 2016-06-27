module StateMachine
  class Transition
    attr_reader :from, :to

    def initialize(from, to, &block)
      @from = from
      @to = to
      @has_block = true if block_given?
      @block = block
    end

    def execute
      @block.call if @has_block
      @to
    end

    def assert_valid(states)
      raise StateMachine::InvalidStateTransition unless states.include? from
      raise StateMachine::InvalidStateTransition unless states.include? to
    end
  end
end
