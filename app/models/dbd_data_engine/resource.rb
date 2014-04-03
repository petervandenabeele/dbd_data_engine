module DbdDataEngine
  class Resource

    extend ::DbdDataEngine::ResourceSelectors

    def self.used_predicates
      schema_resources = ::DbdOnto::Schema.new.resources
      meta_resources = ::DbdOnto::Meta.new.resources
      dbd_resources = current_graph.resources
      resources = schema_resources +
                  meta_resources +
                  dbd_resources
      predicate_defining_resources = select_with_defines_predicate(resources)
      used_predicate_defining_resources = select_used(predicate_defining_resources)
      extract_defines_predicate_object(used_predicate_defining_resources)
    end

  private

    def self.filename
      DbdDataEngine.default_CSV_location
    end

    def self.current_graph
      Dbd::Graph.new.from_unsorted_CSV_file(filename)
    end

    def self.select_used(resources)
      resources.select do |resource|
        single_fact_on_predicate(resource, 'meta:predicate_used') ||
        # hack ... all predicates from Meta ontology always used
        single_fact_on_predicate(resource, 'meta:defines_predicate').object.start_with?('meta:')
      end
    end

    def self.extract_defines_predicate_object(resources)
      resources.map do |resource|
        single_fact_on_predicate(resource, 'meta:defines_predicate').object
      end.map do |predicate|
        group, detail = predicate.split(':')
        ["#{detail} (#{group})", predicate]
      end
    end

  end
end
