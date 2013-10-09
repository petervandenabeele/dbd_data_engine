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
end
