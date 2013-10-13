class FactWithContext
  attr_reader :fact

  def initialize(options)
    @fact = options.fetch(:fact)
    @graph = options.fetch(:graph)
  end

  def context_summary
    context = @graph.by_subject(@fact.context_subject)
    context_presenter = ContextPresenter.new(context: context)
    context_presenter.context_summary
  end

end
