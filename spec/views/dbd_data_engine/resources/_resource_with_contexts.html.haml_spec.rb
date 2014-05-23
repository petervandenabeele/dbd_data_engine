require 'spec_helper'

describe 'dbd_data_engine/resources/_resource_with_contexts.html.haml' do

  let(:graph) { TestFactories::Graph.full }
  let(:resource) { graph.resources.first }
  let(:fact) {  resource.first }
  let(:resource_with_contexts) { ResourceWithContexts.new(resource: resource, graph: graph) }

  before(:each) do
    render 'dbd_data_engine/resources/resource_with_contexts', resource_with_contexts: resource_with_contexts
  end

  it 'renders the resource subject' do
    expect(rendered).to have_css('td', text: fact.subject)
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
