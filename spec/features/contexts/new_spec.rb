require 'spec_helper'

module DbdDataEngine
  describe ContextsController do
    describe 'GET /data/contexts/new' do
      context 'routing' do
        it 'new_contexts_path is correct' do
          dbd_data_engine.new_context_path.should == '/data/contexts/new'
        end
      end

      context 'page content' do

        before(:each) do
          visit(dbd_data_engine.new_context_path)
        end

        it 'talks about a new context' do
          expect(page.text).to match(/new context/i)
        end

        it 'has a field array with predicates' do
          expect(page).to have_field('predicate[]', type: 'text', count: 6)
        end

        it 'has a field array with predicate context:visibility' do
          expect(page).to have_field('predicate[]', type: 'text', with: 'context:visibility')
        end

        it 'has a field array with objects' do
          expect(page).to have_field('object[]', count: 6)
        end
      end
    end
  end
end
