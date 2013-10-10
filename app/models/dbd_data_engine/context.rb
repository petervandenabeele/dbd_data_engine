module DbdDataEngine
  class Context

    def self.predicates
      resources = to_resources(::DbdOnto::Context.new)
      predicate_defining_resources = select_with_defines_predicate(resources)
      make_predicate_label_hash(predicate_defining_resources)
    end

    def self.public_today
      context_from_context_facts(public_today_context_facts)
    end

    def self.personal_today
      context_from_context_facts(personal_today_context_facts)
    end

    def self.business_today
      context_from_context_facts(business_today_context_facts)
    end

  private

    def self.context_from_context_facts(context_fact_array)
      Dbd::Context.new.tap do |context|
        context_fact_array.each do |predicate, object|
          context << Dbd::ContextFact.new(predicate: predicate, object: object)
        end
      end
    end

    def self.public_today_context_facts
      today = Date.today
      {'context:visibility' => 'public',
       'context:encryption' => 'clear',
       'context:license' => "CC BY, Copyright #{today.year} Peter Vandenabeele",
       'dc:source' => 'manual by Peter Vandenabeele',
       'dc:creator' => 'Peter Vandenabeele',
       'dcterms:created' => today.to_s}
    end

    def self.personal_today_context_facts
      today = Date.today
      {'context:visibility' => 'personal',
       'context:encryption' => 'encrypted',
       'context:license' => "All rights reserved, Copyright #{today.year} Peter Vandenabeele",
       'dc:source' => 'manual by Peter Vandenabeele',
       'dc:creator' => 'Peter Vandenabeele',
       'dcterms:created' => today.to_s}
    end

    def self.business_today_context_facts
      today = Date.today
      {'context:visibility' => 'business',
       'context:encryption' => 'encrypted',
       'context:license' => "All rights reserved, Copyright #{today.year} Peter Vandenabeele",
       'dc:source' => 'manual by Peter Vandenabeele',
       'dc:creator' => 'Peter Vandenabeele',
       'dcterms:created' => today.to_s}
    end

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
