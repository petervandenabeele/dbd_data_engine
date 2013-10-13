require 'spec_helper'

describe 'dbd_data_engine/resources/index.html.haml' do

  let(:resources_with_contexts) { [[]] }

  before(:each) do
    assign(:resources_with_contexts, resources_with_contexts)
  end

  it 'renders' do
    render
  end

  it 'renders the resource partial' do
    render.should render_template(partial: '_resource_with_contexts')
  end

  it 'renders the div class resource' do
    render.should have_css('div[class=resource]')
  end

  it 'renders the links partial' do
    render.should render_template('dbd_data_engine/shared/_links')
  end
end
