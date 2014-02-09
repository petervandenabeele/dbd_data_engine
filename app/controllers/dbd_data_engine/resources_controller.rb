require_dependency 'dbd_data_engine/application_controller'

module DbdDataEngine
  class ResourcesController < ApplicationController

    def index
      @resources_with_contexts = resources_with_contexts(current_graph)
    end

    def new
      @contexts = ['public today', 'personal today', 'business today']
      @predicates = Resource.used_predicates
    end

    def create
      # FIXME refactor to smaller function (green first, refactor next)
      @context = Context.default_from_params(params[:context], current_graph)
      @resource = Dbd::Resource.new(context_subject: @context.subject)
      [params[:predicate], params[:object]].transpose.each do |predicate, object|
        @resource << Dbd::Fact.new(
          predicate: predicate,
          object_type: 's',
          object: object)
      end

      # prepare the graph to append
      append_graph = Dbd::Graph.new
      append_graph << @context unless @context.first.time_stamp # only if not yet persisted?
      append_graph << @resource
      # TODO this can probably move to Dbd::Graph#append_to_file(filename)
      append_csv = append_graph.to_CSV
      File.open(filename, 'a') do |f|
        f.syswrite append_csv
      end

      redirect_to('/data/resources')
    end

  private

    def filename
      DbdDataEngine.default_CSV_location
    end

    def current_graph
      Dbd::Graph.new.from_unsorted_CSV_file(filename)
    end

    def resources_with_contexts(graph)
      graph.resources.map do |resource|
        ResourceWithContexts.new(
          resource: resource,
          graph: graph)
      end
    end

  end
end
