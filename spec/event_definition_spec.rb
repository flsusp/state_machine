require 'rspec'

describe StateMachine do
  context 'with valid events and transitions' do
    let(:stub_obj) do
      result = double
      allow(result).to receive(:register).with(:created_to_finished)
      allow(result).to receive(:register).with(:started_to_finished)
      result
    end
    let(:valid_events_class) do
      stub_obj_ref = stub_obj
      Class.new do
        include StateMachine

        state :created, initial: true
        state :started
        state :finished

        event :start do |event|
          event.from :created, to: :started
        end
        event :finish do |event|
          event.from :created, to: :finished do
            stub_obj_ref.register(:created_to_finished)
          end
          event.from :started, to: :finished do
            stub_obj_ref.register(:started_to_finished)
          end
        end
      end
    end

    let(:instance) { valid_events_class.new }

    context 'when calls an event without a transition hook' do
      before do
        instance.start
      end

      it 'expects state to change' do
        expect(instance.created?).to be_falsy
        expect(instance.started?).to be_truthy
      end
    end

    context 'when calls an event with a transition hook' do
      before do
        instance.finish
      end

      it 'expects state to change' do
        expect(instance.created?).to be_falsy
        expect(instance.finished?).to be_truthy
      end

      it 'expects hook to be called' do
        expect(stub_obj).to have_received(:register).with(:created_to_finished)
        expect(stub_obj).not_to have_received(:register).with(:started_to_finished)
      end
    end
  end
end
