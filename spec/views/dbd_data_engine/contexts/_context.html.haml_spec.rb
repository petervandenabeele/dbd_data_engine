require 'spec_helper'

describe 'dbd_data_engine/contexts/_context.html.haml' do

  let(:context) do
    graph = TestFactories::Graph.full
    context = graph.to_a[0..1]
  end

  before(:each) { render 'dbd_data_engine/contexts/context', context: context }

  it 'shows a predicate' do
    rendered.should have_css('div.context td', text: 'context:visibility')
  end

  it 'shows an object' do
    rendered.should have_css('div.context td', text: 'public')
  end

  it 'shows the context_summary' do
    rendered.should have_css('div.context h3', text: 'public 2013-10-13')
  end
end

