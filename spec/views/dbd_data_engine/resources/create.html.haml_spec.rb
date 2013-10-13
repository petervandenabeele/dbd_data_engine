require 'spec_helper'
require 'ostruct'

describe 'dbd_data_engine/resources/create.html.haml' do

  before(:each) do
    fact = OpenStruct.new(predicate: 'foo', object: 'bar')
    context_fact = OpenStruct.new(predicate: 'tux', object: 'ping')
    assign(:resource, [fact])
    assign(:context, [context_fact])
    render
  end

  it 'renders' do
    rendered
  end

  context 'navigation' do
    it 'points to "resources"' do
      rendered.should have_css("a[href='/data/resources']", text: 'resources')
    end

    it 'points to "contexts"' do
      rendered.should have_css("a[href='/data/contexts']", text: 'contexts')
    end

    it 'points to "new resource"' do
      rendered.should have_css("a[href='/data/resources/new']", text: 'new resource')
    end

    it 'points to "new context"' do
      rendered.should have_css("a[href='/data/contexts/new']", text: 'new context')
    end
  end
end
