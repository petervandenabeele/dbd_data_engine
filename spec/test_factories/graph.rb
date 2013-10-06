module TestFactories
  module Graph
    def self.factory_for
      ::Dbd::Graph
    end

    def self.full
      context = TestFactories::Context.context
      resource = TestFactories::Resource.facts_resource(context.subject)
      factory_for.new << context << resource
    end

    def self.new_subject
      Dbd::Fact.factory.new_subject
    end

    def self.full
      Dbd::Graph.new.tap do |graph|
        context_fact = Dbd::ContextFact.new(subject: new_subject,
                                          predicate: 'foobar',
                                          object: 'tuxping')
        fact = Dbd::Fact.new(subject: new_subject,
                           context_subject: context_fact.subject,
                           predicate: 'fact_predicate',
                           object: 'whooha')
        graph << context_fact << fact
      end
    end
  end
end