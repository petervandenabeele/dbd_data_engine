module DbdDataEngine
  class Resource

    extend ::DbdDataEngine::ResourceSelectors

    def self.used_predicates
      resources = ::DbdOnto::Schema.new.resources
      predicate_defining_resources = select_with_defines_predicate(resources)
      used_predicate_defining_resources = select_used(predicate_defining_resources)
      extract_defines_predicate_object(used_predicate_defining_resources)
    end

  private

    def self.select_used(resources)
      resources.select do |resource|
        single_fact_on_predicate(resource, 'meta:predicate_used')
      end
    end

    def self.extract_defines_predicate_object(resources)
      resources.map do |resource|
        single_fact_on_predicate(resource, 'meta:defines_predicate').object
      end
    end

  end
end
