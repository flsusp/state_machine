require 'rspec'

describe StateMachine do
  context 'with valid events and transitions' do
    let(:valid_events_class) do
      Class.new do
        include StateMachine

        state :created, initial: true
        state :started
        state :finished

        event :start do |event|
          event.from :created, to: :started
        end
      end
    end
    let(:instance) { valid_events_class.new }

    context 'when calls an event' do
      before do
        instance.start
      end

      it 'expects state to change' do
        expect(instance.created?).to be_falsy
        expect(instance.started?).to be_truthy
      end
    end
  end
end
