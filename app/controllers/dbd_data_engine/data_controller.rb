require_dependency "dbd_data_engine/application_controller"

module DbdDataEngine
  class DataController < ApplicationController
    def index
    end

    def show
    end

    def new
      @predicates = ['schema:givenName','schema:familyName']
    end

    def create
    end
  end
end