require 'rspec'

describe StateMachine do
  context 'without any state' do
    let(:without_states_class) do
      Class.new do
        include StateMachine
      end
    end

    it 'expects class to be invalid' do
      expect(without_states_class.valid_state_machine?).to be_falsy
    end

    it 'expects instance creation to fail' do
      expect { without_states_class.new }.to raise_error StateMachine::InvalidState
    end
  end

  context 'without an initial valid state' do
    let(:not_initial_state_class) do
      Class.new do
        include StateMachine

        state :opened
        state :closed
      end
    end

    it 'expects class to be invalid' do
      expect(not_initial_state_class.valid_state_machine?).to be_falsy
    end

    it 'expects instance creation to fail' do
      expect { not_initial_state_class.new }.to raise_error StateMachine::InvalidState
    end
  end

  context 'with an initial valid state' do
    let(:valid_initial_state_class) do
      Class.new do
        include StateMachine

        state :opened, initial: true
        state :closed
      end
    end

    it 'expects class to be valid' do
      expect(valid_initial_state_class.valid_state_machine?).to be_truthy
    end

    it 'expects instance creation to not fail' do
      expect { valid_initial_state_class.new }.not_to raise_error
    end

    it 'expects instance to be in the initial state' do
      expect(valid_initial_state_class.new.opened?).to be_truthy
    end

    it 'expects instance not to be in other state' do
      expect(valid_initial_state_class.new.closed?).to be_falsy
    end
  end

  context 'with two initial states' do
    it 'expects class creation to fail' do
      expect do
        Class.new do
          include StateMachine

          state :opened, initial: true
          state :undefined, initial: true
        end
      end.to raise_error StateMachine::MultipleInitialStates
    end
  end

  context 'with two states with the same name' do
    it 'expects class creation to fail' do
      expect do
        Class.new do
          include StateMachine

          state :opened, initial: true
          state :opened
        end
      end.to raise_error StateMachine::MultipleStatesWithSameName
    end
  end

  context 'two state machines with different states' do
    let(:first) do
      Class.new do
        include StateMachine

        state :opened
        state :closed
      end
    end
    let(:second) do
      Class.new do
        include StateMachine

        state :defined
        state :undefined
      end
    end

    it 'expects first class to have states :opened and :closed' do
      expect(first.states).to eql [ :opened, :closed ]
    end

    it 'expects second class to have states :defined and :undefined' do
      expect(second.states).to eql [ :defined, :undefined ]
    end
  end
end
