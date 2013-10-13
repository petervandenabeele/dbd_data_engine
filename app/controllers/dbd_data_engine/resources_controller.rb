require_dependency 'dbd_data_engine/application_controller'

module DbdDataEngine
  class ResourcesController < ApplicationController
    def index
      @resources_with_contexts = resources_with_contexts(current_graph)
    end

    def new
      @contexts = ['public today', 'personal today', 'business today']
      @predicates = ['schema:givenName','schema:familyName']
    end

    def create
      @context = Context.default_from_params(params[:context], current_graph)
      @resource = Dbd::Resource.new(context_subject: @context.subject)
      [params[:predicate], params[:object]].transpose.each do |predicate, object|
        @resource << Dbd::Fact.new(predicate: predicate, object: object)
      end
      append_graph = Dbd::Graph.new
      append_graph << @context unless @context.first.time_stamp # only if not yet persisted?
      append_graph << @resource
      @resources_with_contexts = resources_with_contexts(append_graph)
      # TODO this can probably move to Dbd::Graph#append_to_file(filename)
      append_csv = append_graph.to_CSV
      File.open(filename, 'a') do |f|
        f.syswrite append_csv
      end
    end

  private

    def filename
      DbdDataEngine.default_CSV_location
    end

    def current_graph
      Dbd::Graph.new.from_unsorted_CSV_file(filename)
    end

    # TODO move this to the Dbd::Graph#resources
    def resources(graph)
      graph.subjects.map{ |s| graph.by_subject(s) }.select{ |cs| cs.first.class == Dbd::Fact }
    end

    def resources_with_contexts(graph)
      resources(graph).map do |resource|
        ResourceWithContexts.new(
          resource: resource,
          graph: graph)
      end
    end
  end
end
