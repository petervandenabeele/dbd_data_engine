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

    it 'has table header "predicate"' do
      rendered.should have_xpath('.//table/tr/th', :text => 'predicate')
    end

    it 'has table header "object"' do
      rendered.should have_xpath('.//table/tr/th', :text => 'object')
    end

    it 'has a drop down select box with predicates' do
      rendered.should have_select('predicate', options: ['schema:givenName', 'schema:familyName'])
    end

    it 'has a submit button' do
      rendered.should have_button('Submit')
    end

    it 'has a form that posts to /data/' do
      rendered.should have_xpath('.//form[@action="/data"][@method="post"]', :text => 'predicate')
    end
  end
end
