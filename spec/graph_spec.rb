require 'rspec'
require 'rspec/collection_matchers'
require_relative 'sample_state_machine'

describe StateMachine do
  context 'when returning graph data for sample state machine' do
    nodes, edges = SampleStateMachine.graph

    context 'nodes' do
      it { expect(nodes).to have(3).items }
      it { expect(nodes).to include :sleeping }
      it { expect(nodes).to include :freaking }
      it { expect(nodes).to include :eating }
    end

    context 'edges' do
      it { expect(edges).to have(9).items }
      it { expect(edges).to include({ from: :sleeping, to: :sleeping, label: :tired }) }
      it { expect(edges).to include({ from: :sleeping, to: :freaking, label: :bored }) }
      it { expect(edges).to include({ from: :sleeping, to: :eating, label: :hungry }) }
      it { expect(edges).to include({ from: :freaking, to: :sleeping, label: :tired }) }
      it { expect(edges).to include({ from: :freaking, to: :freaking, label: :bored }) }
      it { expect(edges).to include({ from: :freaking, to: :eating, label: :hungry }) }
      it { expect(edges).to include({ from: :eating, to: :sleeping, label: :tired }) }
      it { expect(edges).to include({ from: :eating, to: :freaking, label: :bored }) }
      it { expect(edges).to include({ from: :eating, to: :eating, label: :hungry }) }
    end
  end
end
