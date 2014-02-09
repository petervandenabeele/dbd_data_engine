module DbdDataEngine
  module ResourceSelectors

    # TODO implement some of these methods on Dbd gem to clean-up

    def select_with_defines_predicate(resources)
      resources.select do |resource|
        single_fact_on_predicate(resource, 'meta:defines_predicate')
      end
    end

    def single_fact_on_predicate(resource, predicate)
      resource.select do |fact|
        fact.predicate == predicate
      end.single
    end

  end
end
