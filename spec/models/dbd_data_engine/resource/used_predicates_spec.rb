require 'spec_helper'

module DbdDataEngine
  describe Resource do
    describe 'used_predicates' do

      let(:example_used_predicates) do
        ['schema:about',
         'schema:address',
         'schema:familyName',
         'schema:givenName']
      end

      it 'has all the used predicates' do
        expect(example_used_predicates - described_class.used_predicates).to be_empty
      end
    end
  end
end
