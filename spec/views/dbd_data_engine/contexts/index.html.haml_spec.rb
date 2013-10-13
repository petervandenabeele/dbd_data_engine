require 'spec_helper'

describe 'dbd_data_engine/contexts/index.html.haml' do

  before(:each) { assign(:contexts, [1]) }

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
