require_dependency "dbd_data_engine/application_controller"

module DbdDataEngine
  class ResourcesController < ApplicationController
    def index
      graph = Dbd::Graph.new
      graph = graph.from_unsorted_CSV_file(filename)
      # TODO move this to the Dbd::Graph#contexts
      @resources = graph.subjects.map{ |s| graph.by_subject(s) }.select{ |cs| cs.first.class == Dbd::Fact }
    end

    def new
      @predicates = ['schema:givenName','schema:familyName']
    end

    def create
      graph = Dbd::Graph.new
      @resource = Dbd::Resource.new(context_subject: Dbd::Context.new_subject)
      [params[:predicate], params[:object]].transpose.each do |predicate, object|
        fact = Dbd::Fact.new(predicate: predicate,
                             object:    object)
        @resource << fact
      end
      graph << @resource
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
