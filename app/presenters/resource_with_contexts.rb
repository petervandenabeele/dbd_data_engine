class ResourceWithContexts
  include Enumerable

  def initialize(options)
    @resource = options.fetch(:resource)
    @graph = options.fetch(:graph)
  end

  def each
    @resource.each do |fact|
      yield FactWithContext.new(fact: fact, graph: @graph)
    end
  end
end
