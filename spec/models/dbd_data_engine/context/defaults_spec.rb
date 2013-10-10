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

    def assert_object(context, object)
      context.select{ |cf| cf.object.to_s == object }.size.should == 1
    end

    context 'default context does not yet exist' do

      context 'default_from_params' do
        it 'returns public_today' do
          context = described_class.default_from_params('public today')
          assert_object(context, 'public')
        end

        it 'returns personal_today' do
          context = described_class.default_from_params('personal today')
          assert_object(context, 'personal')
        end

        it 'returns business_today' do
          context = described_class.default_from_params('business today')
          assert_object(context, 'business')
        end

        it 'raises for inexisting param' do
          lambda{ described_class.default_from_params('foo') }.should raise_error(/foo/)
        end
      end

      context 'public_today' do

        let(:context) { described_class.public_today}

        it 'exists' do
          context
        end

        it 'has 6 context_facts' do
          context.select{ |cf| cf.class == Dbd::ContextFact }.size.should == 6
        end

        it 'has a public object' do
          assert_object(context, 'public')
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
          assert_object(context, 'personal')
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

        it 'has a business object' do
          assert_object(context, 'business')
        end
      end
    end
  end
end
