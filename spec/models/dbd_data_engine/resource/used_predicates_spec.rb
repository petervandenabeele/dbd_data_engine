require 'spec_helper'

module DbdDataEngine
  describe Resource do
    describe 'used_predicates' do

      let(:example_used_predicates) do
        [['about (schema)', 'schema:about'],
         ['address (schema)', 'schema:address'],
         ['familyName (schema)', 'schema:familyName'],
         ['givenName (schema)', 'schema:givenName']]
      end

      it 'has all the used predicates' do
        expect(example_used_predicates - described_class.used_predicates).to be_empty
      end
    end
  end
end
