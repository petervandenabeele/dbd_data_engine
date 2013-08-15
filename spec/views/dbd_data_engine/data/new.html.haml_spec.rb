require 'spec_helper'

describe 'dbd_data_engine/data/new.html.haml' do
  context 'renders' do

    before(:each) do
      @predicates = ['schema:givenName', 'schema:familyName']
      render
    end

    it 'without exceptions' do
      #should_not raise_error
    end

    it 'talks about predicate' do
      rendered.should match(/predicate/i)
    end

    it 'talks about object' do
      rendered.should match(/object/i)
    end

    it 'has a drop down select box with predicates' do
      rendered.should have_select('predicate', options: ['schema:givenName', 'schema:familyName'])
    end

    it 'has a submit button' do
      rendered.should have_button('Submit')
    end
  end
end
