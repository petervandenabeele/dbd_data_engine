require 'spec_helper'

module DbdDataEngine
  describe ResourcesController do
    context 'POST /data/resources' do
      context 'routing' do
        it 'resources_path is correct' do
          dbd_data_engine.resources_path.should == '/data/resources'
        end
      end

      context 'creating the resource from parameters' do

        let(:test_filename) { 'data/test_graph.csv' }

        let(:one_fact) do
          {'predicate' => ['schema:givenName'],
           'object' => ['Peter']}
        end

        let(:two_facts) do
          {'predicate' => ['schema:givenName', 'schema:familyName'],
           'object' => ['Peter', 'Vandenabeele']}
        end

        before(:each) { DbdDataEngine.stub(:default_CSV_location).and_return(test_filename) }

        describe 'with correct parameters' do
          it 'with correct data does_not raise_error' do
            post(dbd_data_engine.resources_path, one_fact)
          end

          it 'calls Dbd::Resource.new' do
            Dbd::Resource.should_receive(:new).and_call_original
            post(dbd_data_engine.resources_path, one_fact)
          end

          before(:each) do
            Dbd::Graph.new.to_CSV_file(test_filename) # empty the file
          end

          def read_back_graph
            File.open(test_filename) do |f|
              Dbd::Graph.new.from_CSV(f)
            end
          end

          context 'with 1 line, creates 1 resource' do

            it 'adds 1 line to the graph' do
              post(dbd_data_engine.resources_path, one_fact)
              read_back_graph.size.should == 1
            end

            it 'shows the result' do
              post(dbd_data_engine.resources_path, one_fact)
              expect(response.body).to include('schema:givenName')
              expect(response.body).to include('Peter')
            end
          end

          context 'with 2 lines, creates 2 resources' do

            it 'adds 2 lines to the graph' do
              post(dbd_data_engine.resources_path, two_facts)
              read_back_graph.size.should == 2
            end

            it 'shows the result' do
              post(dbd_data_engine.resources_path, two_facts)
              expect(response.body).to include('schema:givenName')
              expect(response.body).to include('Peter')
              expect(response.body).to include('schema:familyName')
              expect(response.body).to include('Vandenabeele')
            end
          end
        end
      end
    end
  end
end
