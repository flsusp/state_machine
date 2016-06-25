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

  context 'without a initial valid state' do
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
end
