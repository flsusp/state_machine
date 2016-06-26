module StateMachine
  class Transition
    attr_reader :from

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
  end
end
