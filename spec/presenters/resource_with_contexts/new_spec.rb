require 'spec_helper'

describe ResourceWithContexts do
  context 'klass.new with a resource and a graph' do

    let(:graph) { TestFactories::Graph.full }
    let(:resource) { [graph.last] }
    let(:resource_with_contexts) do
      described_class.new(
        resource: resource,
        graph: graph)
    end

    it 'is enumerable' do
      resource_with_contexts.map #should_not raise_error
    end

    it 'has FactWithContext as members' do
      resource_with_contexts.first.should be_a(FactWithContext)
    end

    context 'raises when new is not given all arguments' do
      it 'without resource' do
        lambda{ described_class.new(graph: graph) }.should raise_error
      end

      it 'without graph' do
        lambda{ described_class.new(resource: resource) }.should raise_error
      end
    end
  end
end
