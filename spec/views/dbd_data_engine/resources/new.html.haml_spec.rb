require 'spec_helper'

describe 'dbd_data_engine/resources/new.html.haml' do
  context 'renders' do

    before(:each) do
      @contexts = ['a', 'b']
      @predicates =
        [
            ['about (schema)', 'schema:about'],
            ['address (schema)', 'schema:address'],
            ['familyName (schema)', 'schema:familyName'],
            ['givenName (schema)', 'schema:givenName'],
        ]
      render
    end

    it 'has table header "predicate"' do
      rendered.should have_css('table>tr>th', text: 'predicate')
    end

    it 'has table header "object"' do
      rendered.should have_css('table>tr>th', text: 'object')
    end

    it 'has an array of drop down select boxes with predicates' do
      rendered.should have_select('predicate[]',
        options:
          [
            'about (schema)',
            'address (schema)',
            'familyName (schema)',
            'givenName (schema)',
          ]
      )
    end

    it 'has a select box with contexts' do
      rendered.should have_select('context', options: ['a', 'b'])
    end

    it 'has an array of fields with objects' do
      rendered.should have_field('object[]')
    end

    it 'has a submit button' do
      rendered.should have_button('Submit')
    end

    it 'has a form that posts to /data/resources' do
      rendered.should have_css('form[@action="/data/resources"][@method="post"]', text: 'predicate')
    end
  end
end
