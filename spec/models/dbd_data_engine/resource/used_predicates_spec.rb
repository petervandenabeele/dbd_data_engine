require 'spec_helper'

module DbdDataEngine
  describe Resource do
    describe 'used_predicates' do

      let(:used_predicates) do
        ['schema:about']
      end

      it 'has all the used predicates' do
        described_class.used_predicates.should == used_predicates
      end
    end
  end
end
