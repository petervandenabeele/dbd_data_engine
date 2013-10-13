require 'spec_helper'

describe ContextPresenter do
  context 'context_summary' do

    let(:graph) { TestFactories::Graph.full }
    let(:context) { graph.to_a[0..1] }
    let(:context_presenter) { described_class.new(context: context) }

    it '#context_summary returns the context_summuary' do
      context_presenter.context_summary.should == 'public 2013-10-13'
    end

    context 'raises when new is not given all arguments' do
      it 'without context' do
        lambda{ described_class.new({}) }.should raise_error
      end
    end
  end
end
