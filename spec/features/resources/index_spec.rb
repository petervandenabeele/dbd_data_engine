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
        graph = Dbd::Graph.new
        graph << Dbd::ContextFact.new(subject: Dbd::Fact.factory.new_subject,
                          predicate: 'foobar',
                          object: 'tuxping')
        Dbd::Graph.any_instance.stub(:from_unsorted_CSV_file).and_return(graph)
      end

      context 'page content' do

        before(:each) do
          visit(dbd_data_engine.resources_path)
        end

        it 'talks about resources' do
          expect(page).to have_text('Resources')
        end

        it 'shows a test resource' do
          expect(page).to have_text('foobar')
          expect(page).to have_text('tuxping')
        end
      end
    end
  end
end
