require 'spec_helper'

describe 'dbd_data_engine/resources/new.html.haml' do
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

    it 'has an array of drop down select boxes with predicates' do
      rendered.should have_select('predicate[]', options: ['schema:givenName', 'schema:familyName'])
    end

    it 'has an array of fields with objects' do
      rendered.should have_field('object[]')
    end

    it 'has a submit button' do
      rendered.should have_button('Submit')
    end

    it 'has a form that posts to /data/resources' do
      rendered.should have_xpath('.//form[@action="/data/resources"][@method="post"]', :text => 'predicate')
    end
  end
end
