module StateMachine
  class InvalidState < StandardError; end
  class MultipleInitialStates < StandardError; end
  class MultipleStatesWithSameName < StandardError; end
  class MultipleEventsWithSameName < StandardError; end
  class InvalidStateTransition < StandardError; end
  class EventWithoutTransitions < StandardError; end
end
