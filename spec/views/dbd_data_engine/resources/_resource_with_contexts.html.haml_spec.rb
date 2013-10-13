require 'spec_helper'

describe 'dbd_data_engine/resources/_resource_with_contexts.html.haml' do

  let(:resource_with_contexts) do
    graph = TestFactories::Graph.full
    fact = graph.last
    resource = [fact]
    ResourceWithContexts.new(resource: resource, graph: graph)
  end

  before(:each) do
    render 'dbd_data_engine/resources/resource_with_contexts', resource_with_contexts: resource_with_contexts
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
