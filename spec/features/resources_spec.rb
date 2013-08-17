require 'spec_helper'

module DbdDataEngine
  describe 'Resources' do
    describe 'GET /data/resources' do
      context 'routing' do
        it 'resources_path is correct' do
          dbd_data_engine.resources_path.should == '/data/resources'
        end
      end

      context 'page content' do

        before(:each) do
          visit(dbd_data_engine.resources_path)
        end

        it 'talks about resources' do
          expect(page).to have_text('Resources')
        end
      end
    end

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

        it 'has a select box with schema:givenName as option' do
          expect(page).to have_select('predicate', options: ['schema:givenName','schema:familyName'])
        end
      end
    end

    describe 'POST /data/resources' do
      context 'routing' do
        it 'resources_path is correct' do
          dbd_data_engine.resources_path.should == '/data/resources'
        end
      end
    end
  end
end
