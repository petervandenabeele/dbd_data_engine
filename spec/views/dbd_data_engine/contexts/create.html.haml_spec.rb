require 'spec_helper'
require 'ostruct'

describe 'dbd_data_engine/contexts/create.html.haml' do

  before(:each) do
    a = OpenStruct.new(predicate: 'foo', object: 'bar')
    assign(:context, [a])
  end

  it 'renders the links partial' do
    render.should render_template('dbd_data_engine/shared/_links')
  end

  it 'renders the context partial' do
    render.should render_template('dbd_data_engine/contexts/_context')
  end
end
