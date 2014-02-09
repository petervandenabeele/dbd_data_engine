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

        context 'resource' do
          it 'talks about a new resource' do
            expect(page).to have_css('h1', text: 'Create a new resource')
          end

          it 'has a select box array with schema:givenName as option' do
            expect(page).to have_css('select#predicate_ > option[value="schema:givenName"]')
          end

          it 'has a select box array with schema:familyName as option' do
            expect(page).to have_css('select#predicate_ > option[value="schema:familyName"]')
          end

          it 'has a field array' do
            expect(page).to have_field('object[]')
          end
        end

        context 'select a context' do
          it 'has a label "context"' do
            expect(page).to have_css('label', text: 'Context')
          end

          it 'has a select box for the context' do
            expect(page).to have_select('context', [])
          end

          it 'has an option "public today"' do
            expect(page).to have_css('select#context > option[value="public today"]')
          end
        end
      end
    end
  end
end
