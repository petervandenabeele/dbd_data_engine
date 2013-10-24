module DbdDataEngine
  class Context

    def self.predicates
      resources = ::DbdOnto::Context.new.resources
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

    def self.default_from_params(context_param, current_graph)
      find_context(context_param, current_graph) || create_context(context_param)
    end

  private

    def self.find_context(context_param, current_graph)
      if current_graph
        # the first occurrence is OK (no drama if multiple)
        current_graph.contexts.detect do |context|
          (cv = single_fact_on_predicate(context, 'context:visibility')) &&
          cv.object == visibility(context_param) &&
          (dc = single_fact_on_predicate(context, 'dcterms:created')) &&
          dc.object == today.to_s
        end
      end
    end

    def self.create_context(context_param)
      case context_param
        when 'public today'
          public_today
        when 'personal today'
          personal_today
        when 'business today'
          business_today
        else
          raise "A valid context must be given (was given: #{context_param})"
      end
    end

    def self.visibility(context_param)
      context_param.split(/ /).first
    end

    def self.today
      Date.today
    end

    def self.context_from_context_facts(context_fact_array)
      Dbd::Context.new.tap do |context|
        context_fact_array.each do |predicate, object_type, object| # splat
          context << Dbd::ContextFact.new(
            predicate: predicate,
            object_type: object_type,
            object: object)
        end
      end
    end

    def self.public_today_context_facts
      [['context:visibility','s','public'],
       ['context:encryption','s','clear'],
       ['context:license','s',"CC BY, Copyright #{today.year} Peter Vandenabeele"]] +
        common_today_context_facts
    end

    def self.personal_today_context_facts
      [['context:visibility','s','personal']] +
        encrypted_and_rights_reserved_and_common
    end

    def self.business_today_context_facts
      [['context:visibility','s','business']] +
        encrypted_and_rights_reserved_and_common
    end

    def self.encrypted_and_rights_reserved_and_common
      [['context:encryption','s','encrypted'],
       ['context:license','s',"All rights reserved, Copyright #{today.year} Peter Vandenabeele"]] +
        common_today_context_facts
    end

    def self.common_today_context_facts
      [['dc:source','s','manual by Peter Vandenabeele'],
       ['dc:creator','s','Peter Vandenabeele'],
       ['dcterms:created','s',today.to_s]]
    end

    # TODO implement some of these methods on Dbd gem to clean-up

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
