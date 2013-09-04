require 'spec_helper'

describe 'dbd_data_engine/data/index.html.haml' do
  it 'renders' do
    render
  end

  it 'links to resources' do
    render
    rendered.should match(%r{<a href="/data/resources">resources</a>})
  end

  it 'links to contexts' do
    render
    rendered.should match(%r{<a href="/data/contexts">contexts</a>})
  end
end
