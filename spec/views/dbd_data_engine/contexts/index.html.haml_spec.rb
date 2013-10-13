require 'spec_helper'

describe 'dbd_data_engine/contexts/index.html.haml' do

  let(:stub_fact) { OpenStruct.new(predicate: 'a', object: 'b') }

  before(:each) { assign(:contexts, [[stub_fact]]) }

  it 'renders' do
    render
  end

  it 'renders the context partial' do
    render.should render_template(partial: '_context')
  end

  it 'renders the links partial' do
    render.should render_template('dbd_data_engine/shared/_links')
  end
end
