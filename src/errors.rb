module StateMachine
  class InvalidState < StandardError; end
  class MultipleInitialStates < StandardError; end
  class MultipleStatesWithSameName < StandardError; end
end
