require 'spec_helper'

module DbdDataEngine
  describe Resource do
    describe 'used_predicates' do

      let(:used_predicates) do
        ['schema:about']
      end

      let(:used_labels) do
        ['about']
      end

      it 'has all the used predicates' do
        described_class.used_predicates.map{ |p| p[:predicate] }.should == used_predicates
      end

      it 'has all the used labels' do
        described_class.used_predicates.map{ |p| p[:label] }.should == used_labels
      end
    end
  end
end
