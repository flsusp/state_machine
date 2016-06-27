class SampleStateMachine
  include StateMachine

  state :sleep, initial: true
  state :eat
  state :freak

  event :tired do |event|
    event.from :sleep, to: :sleep
    event.from :freak, to: :sleep
    event.from :eat, to: :sleep
  end

  event :bored do |event|
    event.from :freak, to: :freak
    event.from :sleep, to: :freak
    event.from :eat, to: :freak
  end

  event :hungry do |event|
    event.from :eat, to: :eat
    event.from :sleep, to: :eat
    event.from :freak, to: :eat
  end
end
