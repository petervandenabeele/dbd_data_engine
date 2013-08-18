module DbdDataEngine
  class Engine < ::Rails::Engine
    isolate_namespace DbdDataEngine

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.assets false
      g.helper false
      g.template_engine :haml
    end
  end

  def self.default_CSV_location
    'tmp/graph.csv'
  end
end
