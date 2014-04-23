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

        let(:test_filename) do
          stub_real_data_dir
          DbdDataEngine.default_CSV_location
        end

        let(:one_fact) do
          {'predicate' => ['schema:givenName'],
           'object' => ['Peter'],
           'context' => 'public today'}
        end

        let(:two_facts) do
          {'predicate' => ['schema:givenName', 'schema:familyName'],
           'object' => ['Peter', 'Vandenabeele'],
           'context' => 'business today'}
        end

        let(:two_other_facts) do
          {'predicate' => ['schema:givenName', 'schema:familyName'],
           'object' => ['Frans', 'VDA'],
           'context' => 'personal today'}
        end

        describe 'with correct parameters' do

          it 'with correct data does_not raise_error' do
            post(dbd_data_engine.resources_path, one_fact)
          end

          before(:each) do
            Dbd::Graph.new.to_CSV_file(test_filename) # empty the file
          end

          def read_back_graph
            Dbd::Graph.new.from_unsorted_CSV_file(test_filename)
          end

          context 'with 1 line, creates 1 resource' do

            before(:each) { post(dbd_data_engine.resources_path, one_fact) }

            it 'adds 1 resource to the graph' do
              read_back_graph.resources.size.should == 1
            end

            it 'redirects to resources' do
              expect(response).to redirect_to('/data/resources')
            end
          end

          context 'with 2 lines, creates resource with 2 facts' do

            before(:each) { post(dbd_data_engine.resources_path, two_facts) }

            it 'adds 2 lines to the graph' do
              read_back_graph.size.should == 8
            end

            it 'the 2 facts have the same subject (1 resource)' do
              read_back_graph.resources.size.should == 1
            end
          end

          context 'with 2 submits of 2 lines, creates 2 resources' do
            context 'submits directly after each other' do

              before(:each) do
                post(dbd_data_engine.resources_path, two_facts)
                post(dbd_data_engine.resources_path, two_other_facts)
              end

              it 'adds 2 resources to the graph in the file' do
                read_back_graph.resources.size.should == 2
              end
            end
          end

          context 'with a context, finds or creates and uses that context' do
            context 'context did not yet exist' do

              before(:each) { post(dbd_data_engine.resources_path, one_fact) }

              it 'adds 1 resource to the graph' do
                read_back_graph.resources.size.should == 1
              end

              it 'adds 1 context to the graph' do
                read_back_graph.contexts.size.should == 1
              end
            end
          end

          context 'with multi-threaded requests does a clean write' do

            before(:each) { pending("multi-threaded tests fail on JRuby") if RUBY_PLATFORM == 'java' }

            it 'does not fail on parallel access (also tested on 1000.times)' do
              threads = []
              [two_facts, two_other_facts].each do |resource|
                threads << Thread.new(resource) do |_resource|
                  10.times { post(dbd_data_engine.resources_path, _resource) }
                end
              end
              threads.each { |thread| thread.join }
              read_back_graph
            end
          end
        end
      end
    end
  end
end
