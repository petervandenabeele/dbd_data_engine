require 'spec_helper'
require 'ostruct'

describe 'dbd_data_engine/contexts/create.html.haml' do
  it 'renders' do
    a = OpenStruct.new(predicate: 'foo', object: 'bar')
    @context = [a]
    render
  end

  it 'renders the links partial' do
    render.should render_template('dbd_data_engine/shared/_links')
  end
end
