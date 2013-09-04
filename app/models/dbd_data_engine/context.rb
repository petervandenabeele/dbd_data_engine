module DbdDataEngine
  class Context

    def self.predicates
      resources = to_resources(::DbdOnto::Context.new)
      predicate_defining_resources = select_with_defines_predicate(resources)
      make_predicate_label_hash(predicate_defining_resources)
    end

  private

    # TODO implement these methods on Dbd gem to clean-up

    def self.to_resources(context)
      context.subjects.map do |subject|
        context.by_subject(subject)
      end
    end

    def self.select_with_defines_predicate(resources)
      resources.select do |resource|
        single_fact_on_predicate(resource, 'meta:defines_predicate')
      end
    end

    def self.make_predicate_label_hash(resources)
      resources.map do |resource|
        predicate = single_fact_on_predicate(resource, 'meta:defines_predicate').object
        label = single_fact_on_predicate(resource, 'rdfs:label').object
        { predicate: predicate,
          label: label }
      end
    end

    def self.single_fact_on_predicate(resource, predicate)
      resource.select do |fact|
        fact.predicate == predicate
      end.single
    end
  end
end
