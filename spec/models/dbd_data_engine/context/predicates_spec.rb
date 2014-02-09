require 'spec_helper'

module DbdDataEngine
  describe Context do

    let(:context_predicates) do
      ['context:visibility',
       'context:encryption',
       'context:license',
       'dc:source',
       'dc:creator',
       'dcterms:created']
    end

    let(:context_labels) do
      ['Visibility',
       'Encryption',
       'License',
       'Source',
       'Creator',
       'Created']
    end

    it 'has all the context predicates' do
      described_class.predicates.map{ |p| p[:predicate] }.should == context_predicates
    end

    it 'has all the context labels' do
      described_class.predicates.map{ |p| p[:label] }.should == context_labels
    end
  end
end
