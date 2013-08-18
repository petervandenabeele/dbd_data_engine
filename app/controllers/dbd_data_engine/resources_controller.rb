require_dependency "dbd_data_engine/application_controller"

module DbdDataEngine
  class ResourcesController < ApplicationController
    def index
    end

    def new
      @predicates = ['schema:givenName','schema:familyName']
    end

    def create
      graph = Dbd::Graph.new
      @resource = Dbd::Resource.new(context_subject: Dbd::Context.new_subject)
      [params[:predicate], params[:object]].transpose.each do |predicate, object|
        fact = Dbd::Fact.new({predicate: predicate,
                              object:    object})
        @resource << fact
      end
      graph << @resource
      graph.to_CSV_file(DbdDataEngine.default_CSV_location)
    end
  end
end
