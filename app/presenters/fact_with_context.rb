class FactWithContext
  attr_reader :fact

  def initialize(options)
    @fact = options[:fact]
    @graph = options[:graph]
    raise 'fact: is a required option' unless @fact
    raise 'graph: is a required option' unless @graph
  end

  def context_summary
    context = @graph.by_subject(@fact.context_subject)
    visibility = get_objects_for_predicate(context, 'context:visibility')
    created = get_objects_for_predicate(context, 'dcterms:created')
    "#{visibility.join(', ')} #{created.join(', ')}"
  end

private

  def get_objects_for_predicate(context, predicate)
    context.select{ |cf| cf.predicate == predicate}.map(&:object)
  end
end
