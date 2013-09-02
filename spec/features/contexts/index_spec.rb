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
        graph = Dbd::Graph.new
        graph << Dbd::ContextFact.new(subject: Dbd::Fact.factory.new_subject,
                          predicate: 'foobar',
                          object: 'tuxping')
        Dbd::Graph.any_instance.stub(:from_unsorted_CSV_file).and_return(graph)
      end

      context 'page content' do

        before(:each) do
          visit(dbd_data_engine.contexts_path)
        end

        it 'talks about contexts' do
          expect(page).to have_text('Contexts')
        end

        it 'shows a test context' do
          expect(page).to have_text('foobar')
          expect(page).to have_text('tuxping')
        end
      end
    end
  end
end
