require 'spec_helper'

describe FactWithContext do
  context 'klass.new with a fact and a graph' do

    let(:graph) { TestFactories::Graph.full }
    let(:fact_with_context) { described_class.new(fact: graph.last, graph: graph) }

    it '#fact returns the fact' do
      fact_with_context.fact.object.should == 'whooha'
    end

    it '#context_summary returns a string' do
      fact_with_context.context_summary.should be_a(String)
    end

    it '#context_summary should be based on visibility and created date' do
      fact_with_context.context_summary.should == 'public 2013-10-13'
    end

    context 'raises when new is not given all arguments' do
      it 'without fact' do
        lambda{ described_class.new(graph: graph) }.should raise_error
      end

      it 'without graph' do
        lambda{ described_class.new(fact: graph.last) }.should raise_error
      end
    end
  end
end
