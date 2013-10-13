require 'spec_helper'
require 'rspec/mocks'

module DbdDataEngine
  describe ContextsController do
    describe 'GET /data/contexts' do
      context 'routing' do
        it 'contexts_path is correct' do
          dbd_data_engine.contexts_path.should == '/data/contexts'
        end
      end

      ::RSpec::Mocks.setup(self)

      before(:each) do
        Dbd::Graph.any_instance.stub(:from_unsorted_CSV_file).
          and_return(TestFactories::Graph.full)
      end

      context 'page content' do

        before(:each) do
          visit(dbd_data_engine.contexts_path)
        end

        it 'talks about contexts' do
          expect(page).to have_text('Contexts')
        end

        it 'shows a test context' do
          expect(page).to have_text('context:visibility')
          expect(page).to have_text('public')
        end

        it 'does not show Facts (only Contexts)' do
          expect(page).to_not have_text('fact_predicate')
          expect(page).to_not have_text('whooha')
        end
      end
    end
  end
end
