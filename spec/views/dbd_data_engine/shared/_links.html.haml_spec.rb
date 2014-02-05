require 'spec_helper'

describe 'dbd_data_engine/shared/_links.html.haml' do

  before(:each) do
    render 'dbd_data_engine/shared/links'
  end

  it 'renders the link to ontologies' do
    rendered.should have_css('a[href="/ontologies"]', text: 'ontologies')
  end

  it 'renders the link to resources' do
    rendered.should have_css('a[href="/data/resources"]', text: 'resources')
  end

  it 'renders the link to contexts' do
    rendered.should have_css('a[href="/data/contexts"]', text: 'contexts')
  end

  it 'renders the link to new resource' do
    rendered.should have_css('a[href="/data/resources/new"]', text: 'new resource')
  end

  it 'renders the link to new context' do
    rendered.should have_css('a[href="/data/contexts/new"]', text: 'new context')
  end
end
