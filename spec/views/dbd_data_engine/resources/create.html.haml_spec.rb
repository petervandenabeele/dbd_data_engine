require 'spec_helper'
require 'ostruct'

describe 'dbd_data_engine/resources/create.html.haml' do
  it 'renders' do
    a = OpenStruct.new(predicate: 'foo', object: 'bar')
    @resource = [a]
    render
  end
end
