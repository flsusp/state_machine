class SampleStateMachine
  include StateMachine

  state :sleeping, initial: true
  state :eating
  state :freaking

  event :tired do |event|
    event.from :sleeping, to: :sleeping
    event.from :freaking, to: :sleeping
    event.from :eating, to: :sleeping
  end

  event :bored do |event|
    event.from :freaking, to: :freaking
    event.from :sleeping, to: :freaking
    event.from :eating, to: :freaking
  end

  event :hungry do |event|
    event.from :eating, to: :eating
    event.from :sleeping, to: :eating
    event.from :freaking, to: :eating
  end
end
