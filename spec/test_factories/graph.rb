module TestFactories
  module Graph
    def self.factory_for
      ::Dbd::Graph
    end

    def self.new_subject
      Dbd::Fact.factory.new_subject
    end

    def self.full
      Dbd::Graph.new.tap do |graph|
        context_subject = new_subject
        visibility_context_fact = Dbd::ContextFact.new(
          subject: context_subject,
          predicate: 'context:visibility',
          object: 'public')
        created_context_fact = Dbd::ContextFact.new(
          subject: context_subject,
          predicate: 'dcterms:created',
          object: '2013-10-13')
        fact = Dbd::Fact.new(
          subject: new_subject,
          context_subject: context_subject,
          predicate: 'fact_predicate',
          object: 'whooha')
        graph << visibility_context_fact << created_context_fact << fact
      end
    end
  end
end