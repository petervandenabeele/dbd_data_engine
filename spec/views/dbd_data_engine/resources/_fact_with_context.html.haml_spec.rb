require 'spec_helper'

describe 'dbd_data_engine/resources/_fact_with_context.html.haml' do

  let(:fact_with_context) do
    graph = TestFactories::Graph.full
    fact = graph.last
    FactWithContext.new(fact: fact, graph: graph)
  end

  before(:each) do
    render 'dbd_data_engine/resources/fact_with_context', fact_with_context: fact_with_context
  end

  it 'renders the fact predicate' do
    rendered.should have_css('td', text: 'fact_predicate')
  end

  it 'renders the fact object' do
    rendered.should have_css('td', text: 'whooha')
  end

  it 'renders the context_summary' do
    rendered.should have_css('td', text: 'public 2013-10-13')
  end
end
