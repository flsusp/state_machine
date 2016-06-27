# StateMachine - Playing with metaprogramming
Simple ruby state machine module.

### Simple Example
```ruby
class SampleStateMachine
  include StateMachine

  state :sleeping, initial: true
  state :eating
  state :freaking

  event :tired do |event|
    event.from :sleeping, to: :sleeping do
        do_something_here_when_state_changes
    end
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
```

Examples of usage (using an instance of ```SampleStateMachine```):

```ruby
example = SampleStateMachine.new
example.current_state # [:sleeping]
example.sleeping? # [true]
example.eating? # [false]
example.hungry
example.current_state # [:eating]
example.can_bored? # [true]
```
