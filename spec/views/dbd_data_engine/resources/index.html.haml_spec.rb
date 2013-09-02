require 'spec_helper'

describe 'dbd_data_engine/resources/index.html.haml' do

  let(:resources) { [:foo] }

  before(:each) { @resources = resources }

  it 'renders' do
    render
  end

  it 'renders the resource partial' do
    render.should render_template(partial: '_resource')
  end
end
