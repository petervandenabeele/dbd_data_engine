require 'spec_helper'

module DbdDataEngine
  describe ContextsController do
    context 'POST /data/contexts' do
      context 'routing' do
        it 'contexts_path is correct' do
          dbd_data_engine.contexts_path.should == '/data/contexts'
        end
      end

      context 'creating the resource from parameters' do

        let(:test_filename) do
          stub_real_data_dir
          DbdDataEngine.default_CSV_location
        end

        let(:one_fact) do
          {'predicate' => ['schema:givenName'],
           'object' => ['Peter']}
        end

        let(:two_facts) do
          {'predicate' => ['schema:givenName', 'schema:familyName'],
           'object' => ['Peter', 'Vandenabeele']}
        end

        let(:two_other_facts) do
          {'predicate' => ['schema:givenName', 'schema:familyName'],
           'object' => ['Frans', 'VDA']}
        end

        describe 'with correct parameters' do
          it 'with correct data does_not raise_error' do
            post(dbd_data_engine.contexts_path, one_fact)
          end

          it 'calls Dbd::Context.new' do
            Dbd::Context.should_receive(:new).and_call_original
            post(dbd_data_engine.contexts_path, one_fact)
          end

          before(:each) do
            Dbd::Graph.new.to_CSV_file(test_filename) # empty the file
          end

          def read_back_graph
            Dbd::Graph.new.from_unsorted_CSV_file(test_filename)
          end

          context 'with 1 line, creates 1 resource' do

            before(:each) { post(dbd_data_engine.contexts_path, one_fact) }

            it 'adds 1 line to the graph' do
              read_back_graph.size.should == 1
            end

            it 'shows the result' do
              expect(response.body).to include('schema:givenName')
              expect(response.body).to include('Peter')
            end
          end

          context 'with 2 lines, creates resource with 2 facts' do

            before(:each) { post(dbd_data_engine.contexts_path, two_facts) }

            it 'adds 2 lines to the graph' do
              read_back_graph.size.should == 2
            end

            it 'the 2 facts have the same subject (1 resource)' do
              read_back_graph.map(&:subject).uniq.size.should == 1
            end

            it 'shows the result' do
              expect(response.body).to include('schema:givenName')
              expect(response.body).to include('Peter')
              expect(response.body).to include('schema:familyName')
              expect(response.body).to include('Vandenabeele')
            end
          end

          context 'with 2 submits of 2 lines, creates 2 contexts' do
            context 'submits directly after each other' do

              before(:each) do
                post(dbd_data_engine.contexts_path, two_facts)
                post(dbd_data_engine.contexts_path, two_other_facts)
              end

              it 'adds 4 lines to the graph in the file' do
                read_back_graph.size.should == 4
              end

              it 'the 4 facts are of 2 contexts' do
                read_back_graph.map(&:subject).uniq.size.should == 2
              end
            end

            it 'shows the results for each submit' do
              post(dbd_data_engine.contexts_path, two_facts)
              expect(response.body).to include('schema:givenName')
              expect(response.body).to include('Peter')
              expect(response.body).to include('schema:familyName')
              expect(response.body).to include('Vandenabeele')
              post(dbd_data_engine.contexts_path, two_other_facts)
              expect(response.body).to include('Frans')
              expect(response.body).to include('VDA')
            end
          end
        end
      end
    end
  end
end
