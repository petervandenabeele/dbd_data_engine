require 'spec_helper'
require 'rspec/mocks'

module DbdDataEngine
  describe ResourcesController do
    describe 'GET /data/resources' do
      context 'routing' do
        it 'resources_path is correct' do
          dbd_data_engine.resources_path.should == '/data/resources'
        end
      end

      ::RSpec::Mocks.setup(self)

      before(:each) do
        Dbd::Graph.any_instance.stub(:from_unsorted_CSV_file).
          and_return(TestFactories::Graph.full)
      end

      context 'page content' do

        before(:each) do
          visit(dbd_data_engine.resources_path)
        end

        it 'talks about resources' do
          expect(page).to have_text('Resources')
        end

        it 'does not show Contexts (alleen Facts)' do
          expect(page).to_not have_text('foobar')
          expect(page).to_not have_text('tuxping')
        end

        it 'shows a test resource' do
          expect(page).to have_text('fact_predicate')
          expect(page).to have_text('whooha')
        end
      end
    end
  end
end
