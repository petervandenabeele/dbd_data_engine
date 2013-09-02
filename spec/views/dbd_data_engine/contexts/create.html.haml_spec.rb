require 'spec_helper'
require 'ostruct'

describe 'dbd_data_engine/contexts/create.html.haml' do
  it 'renders' do
    a = OpenStruct.new(predicate: 'foo', object: 'bar')
    @context = [a]
    render
  end
end
