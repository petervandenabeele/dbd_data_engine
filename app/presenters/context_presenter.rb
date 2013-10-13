class ContextPresenter
  def initialize(options)
    @context = options.fetch(:context)
  end

  def context_summary
    visibility = get_objects_for_predicate(@context, 'context:visibility')
    created = get_objects_for_predicate(@context, 'dcterms:created')
    "#{visibility.join(', ')} #{created.join(', ')}"
  end

private

  def get_objects_for_predicate(context, predicate)
    context.select{ |cf| cf.predicate == predicate }.map(&:object)
  end

end