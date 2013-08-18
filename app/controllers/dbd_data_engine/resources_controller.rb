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
      fact = Dbd::Fact.new({predicate: params[:predicate].first,
                              object:    params[:object].first})
      @resource << fact
      graph << @resource
      graph.to_CSV_file(DbdDataEngine.default_CSV_location)
    end
  end
end
