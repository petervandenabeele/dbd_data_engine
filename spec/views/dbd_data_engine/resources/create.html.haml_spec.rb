require 'spec_helper'
require 'ostruct'

describe 'dbd_data_engine/resources/create.html.haml' do
  it 'renders' do
    fact = OpenStruct.new(predicate: 'foo', object: 'bar')
    context_fact = OpenStruct.new(predicate: 'tux', object: 'ping')
    @resource = [fact]
    @context = [context_fact]
    render
  end

  context 'navigation' do
    it 'points to "resources"' do
      render.should have_css("a[href='/data/resources']", text: 'resources')
    end

    it 'points to "contexts"' do
      render.should have_css("a[href='/data/contexts']", text: 'contexts')
    end

    it 'points to "new resource"' do
      render.should have_css("a[href='/data/resources/new']", text: 'new resource')
    end

    it 'points to "new context"' do
      render.should have_css("a[href='/data/contexts/new']", text: 'new context')
    end
  end
end
