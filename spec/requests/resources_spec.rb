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
          {"predicate" => ["schema:givenName"], "object" => ["P"]}
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

          context 'with 1 line, creates 1 resource' do

            it 'adds 1 line to the graph' do
              DbdDataEngine.stub(:default_CSV_location).and_return(test_filename)
              Dbd::Graph.new.to_CSV_file(test_filename) # empty the file
              post(dbd_data_engine.resources_path, one_fact)
              graph = File.open(test_filename) do |f|
                Dbd::Graph.new.from_CSV(f)
              end
              graph.size.should == 1
            end
          end
        end
      end
    end
  end
end
