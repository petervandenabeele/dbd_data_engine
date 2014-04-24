require 'spec_helper'

module DbdDataEngine
  describe Resource do
    describe 'used_predicates' do

      before(:each) do
        stub_real_data_dir
        File.open(DbdDataEngine.default_CSV_location, "w") do |f|
          f.write <<EOS
"2014-04-23 06:14:40.852155565 UTC","00a77b19-c11b-47f2-8bdd-4e8680687832","a85012ee-b31d-4402-84bb-9db33cbadfdc","50f2d11d-8a0c-4832-bca9-9e240afc83bb","meta:defines_predicate","s","dbd:test"
"2014-04-23 06:14:40.852176070 UTC","39b6bffa-008d-43b4-ae02-8cc4d4a9c3e2","a85012ee-b31d-4402-84bb-9db33cbadfdc","50f2d11d-8a0c-4832-bca9-9e240afc83bb","meta:predicate_used","s","true"
EOS
        end
      end

      let(:example_used_predicates) do
        [
          ['defines_predicate (meta)', 'meta:defines_predicate'],
          ['predicate_used (meta)', 'meta:predicate_used'],
          ['type (rdf)', 'rdf:type'],
          ['about (schema)', 'schema:about'],
          ['address (schema)', 'schema:address'],
          ['familyName (schema)', 'schema:familyName'],
          ['givenName (schema)', 'schema:givenName'],
          ['test (dbd)', 'dbd:test'],
        ]
      end

      it 'has all the used predicates' do
        expect(example_used_predicates - described_class.used_predicates).to be_empty
      end
    end
  end
end
