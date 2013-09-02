require 'spec_helper'

module DbdDataEngine
  describe Context do
    let(:context_predicates) {
      ['context:visibility',
       'context:encryption',
       'context:license',
       'dc:source',
       'dc:creator',
       'dcterms:created']}

    it 'has all the context predicates' do
      described_class.predicates.should == context_predicates
    end
  end
end