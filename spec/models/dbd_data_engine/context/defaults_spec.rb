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

    context 'public_today' do

      let(:context) { described_class.public_today}

      it 'exists' do
        context
      end

      it 'has 6 context_facts' do
        context.select{ |cf| cf.class == Dbd::ContextFact }.size.should == 6
      end

      it 'has a public object' do
        context.select{ |cf| cf.object.to_s == 'public' }.size.should == 1
      end
    end

    context 'personal_today' do

      let(:context) { described_class.personal_today}

      it "exists" do
        context
      end

      it "has 6 context_facts" do
        context.select{ |cf| cf.class == Dbd::ContextFact}.size.should == 6
      end

      it 'has a personal object' do
        context.select{ |cf| cf.object.to_s == 'personal' }.size.should == 1
      end
    end

    context 'business_today' do

      let(:context) { described_class.business_today}

      it "exists" do
        context
      end

      it "has 6 context_facts" do
        context.select{ |cf| cf.class == Dbd::ContextFact}.size.should == 6
      end

      it 'has a personal object' do
        context.select{ |cf| cf.object.to_s == 'business' }.size.should == 1
      end
    end
  end
end
