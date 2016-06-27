# StateMachine - Playing with metaprogramming
Simple ruby state machine module.

### Simple Example
```ruby
class SampleStateMachine
  include StateMachine

  state :sleep, initial: true
  state :eat
  state :freak

  event :tired do |event|
    event.from :sleep, to: :sleep do
        do_something_here_when_state_changes
    end
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
```

Examples of usage (using an instance of ```SampleStateMachine```):

```ruby
example = SampleStateMachine.new
example.current_state # [:sleep]
example.sleep? # [true]
example.eat? # [false]
example.hungry
example.current_state # [:eat]
example.can_bored? # [true]
```
