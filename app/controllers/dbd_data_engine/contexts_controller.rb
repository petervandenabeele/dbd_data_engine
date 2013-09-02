require_dependency "dbd_data_engine/application_controller"

module DbdDataEngine
  class ContextsController < ApplicationController
    def index
      graph = Dbd::Graph.new
      graph = graph.from_unsorted_CSV_file(filename)
      @contexts = graph.subjects.map{ |s| graph.by_subject(s) }
    end

    def new
      @predicates = Context.predicates
    end

    def create
      graph = Dbd::Graph.new
      @context = Dbd::Context.new()
      [params[:predicate], params[:object]].transpose.each do |predicate, object|
        context_fact = Dbd::ContextFact.new(predicate: predicate,
                                            object:    object)
        @context << context_fact
      end
      graph << @context
      new_data = graph.to_CSV
      File.open(filename, 'a') do |f|
        f.syswrite new_data
      end
    end

  private

    def filename
      DbdDataEngine.default_CSV_location
    end

  end
end
