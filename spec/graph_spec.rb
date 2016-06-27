require 'rspec'
require 'rspec/collection_matchers'
require_relative 'sample_state_machine'

describe StateMachine do
  context 'when returning graph data for sample state machine' do
    nodes, edges = SampleStateMachine.graph

    context 'nodes' do
      it { expect(nodes).to have(3).items }
      it { expect(nodes).to include :sleep }
      it { expect(nodes).to include :freak }
      it { expect(nodes).to include :eat }
    end

    context 'edges' do
      it { expect(edges).to have(9).items }
      it { expect(edges).to include({ from: :sleep, to: :sleep, label: :tired }) }
      it { expect(edges).to include({ from: :sleep, to: :freak, label: :bored }) }
      it { expect(edges).to include({ from: :sleep, to: :eat, label: :hungry }) }
      it { expect(edges).to include({ from: :freak, to: :sleep, label: :tired }) }
      it { expect(edges).to include({ from: :freak, to: :freak, label: :bored }) }
      it { expect(edges).to include({ from: :freak, to: :eat, label: :hungry }) }
      it { expect(edges).to include({ from: :eat, to: :sleep, label: :tired }) }
      it { expect(edges).to include({ from: :eat, to: :freak, label: :bored }) }
      it { expect(edges).to include({ from: :eat, to: :eat, label: :hungry }) }
    end
  end
end
