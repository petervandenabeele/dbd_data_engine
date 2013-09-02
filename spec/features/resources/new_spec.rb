require 'spec_helper'

module DbdDataEngine
  describe ResourcesController do
    describe 'GET /data/resources/new' do
      context 'routing' do
        it 'new_resources_path is correct' do
          dbd_data_engine.new_resource_path.should == '/data/resources/new'
        end
      end

      context 'page content' do

        before(:each) do
          visit(dbd_data_engine.new_resource_path)
        end

        it 'talks about a new resource' do
          expect(page.text).to match(/new resource/i)
        end

        it 'has a select box array with schema:givenName as option' do
          expect(page).to have_select('predicate[]', options: ['schema:givenName','schema:familyName'])
        end

        it 'has a field array' do
          expect(page).to have_field('object[]')
        end
      end
    end
  end
end
