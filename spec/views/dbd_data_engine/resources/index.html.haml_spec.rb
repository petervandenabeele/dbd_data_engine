require 'spec_helper'

describe 'dbd_data_engine/resources/index.html.haml' do

  let(:resources_with_context) { [{fact: 'foo', context_summary: 'public 2013-10-12'}] }

  before(:each) { @resources_with_context = resources_with_context }

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
