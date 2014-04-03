require 'spec_helper'

module DbdDataEngine
  describe Resource do
    describe 'used_predicates' do

      before(:each) do
        stub_real_data_dir
      end

      let(:example_used_predicates) do
        [
          ['about (schema)', 'schema:about'],
          ['address (schema)', 'schema:address'],
          ['familyName (schema)', 'schema:familyName'],
          ['givenName (schema)', 'schema:givenName'],
          ['defines_predicate (meta)', 'meta:defines_predicate'],
          ['predicate_used (meta)', 'meta:predicate_used'],
        ]
      end

      it 'has all the used predicates' do
        expect(example_used_predicates - described_class.used_predicates).to be_empty
      end
    end
  end
end
