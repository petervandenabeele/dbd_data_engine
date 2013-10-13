class ResourceWithContexts
  include Enumerable

  def initialize(options)
    @resource = options[:resource]
    @graph = options[:graph]
    raise 'resource: is a required option' unless @resource
    raise 'graph: is a required option' unless @graph
  end

  def each
    @resource.each do |fact|
      yield FactWithContext.new(fact: fact, graph: @graph)
    end
  end
end
