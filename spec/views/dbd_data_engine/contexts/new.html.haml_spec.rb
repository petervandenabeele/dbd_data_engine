require 'spec_helper'

describe 'dbd_data_engine/contexts/new.html.haml' do
  context 'renders' do

    before(:each) do
      @predicates = DbdDataEngine::Context.predicates
      render
    end

    it 'without exceptions' do
      #should_not raise_error
    end

    it 'has table header "Predicate"' do
      rendered.should have_css('table>tr>th', text: 'Predicate')
    end

    it 'has table header "Object"' do
      rendered.should have_css('table>tr>th', text: 'Object')
    end

    it 'has an array of fields with predicates' do
      rendered.should have_field('predicate[]')
    end

    it 'has a field with a predicate context:visibility' do
      rendered.should have_field('predicate[]', with: 'context:visibility')
    end

    it 'has an array of fields with objects' do
      rendered.should have_field('object[]')
    end

    it 'has a label for Visibility' do
      rendered.should have_css('table>tr>td>label', text: 'Visibility (context:visibility)')
    end

    it 'has a submit button' do
      rendered.should have_button('Submit')
    end

    it 'has a form that posts to /data/contexts' do
      rendered.should have_xpath('.//form[@action="/data/contexts"][@method="post"]', :text => 'Predicate')
    end
  end
end
