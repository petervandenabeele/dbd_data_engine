require_dependency "dbd_data_engine/application_controller"

module DbdDataEngine
  class ResourcesController < ApplicationController
    def index
      graph = Dbd::Graph.new
      graph = graph.from_unsorted_CSV_file(filename)
      # TODO move this to the Dbd::Graph#resources
      @resources = graph.subjects.map{ |s| graph.by_subject(s) }.select{ |cs| cs.first.class == Dbd::Fact }
    end

    def new
      @contexts = ['public today', 'personal today', 'business today']
      @predicates = ['schema:givenName','schema:familyName']
    end

    def create
      graph = Dbd::Graph.new
      @context = context_from_params
      @resource = Dbd::Resource.new(context_subject: @context.subject)
      [params[:predicate], params[:object]].transpose.each do |predicate, object|
        fact = Dbd::Fact.new(predicate: predicate,
                             object:    object)
        @resource << fact
      end
      graph << @context << @resource
      new_data = graph.to_CSV
      File.open(filename, 'a') do |f|
        f.syswrite new_data
      end
    end

  private

    def filename
      DbdDataEngine.default_CSV_location
    end

    def context_from_params
      case params[:context]
        when 'public today'
          Context.public_today
        when 'personal today'
          Context.personal_today
        when 'business today'
          Context.business_today
        else
          raise "A context must be given"
      end
    end
  end
end
