require 'spec_helper'

describe ResourceWithContexts do
  context 'reader methods' do

    let(:graph) { TestFactories::Graph.full }
    let(:resource) { [graph.last] }
    let(:resource_with_contexts) do
      described_class.new(
        resource: resource,
        graph: graph)
    end

    it 'has a resource method' do
      expect(resource_with_contexts.resource).to eq resource
    end
  end
end
