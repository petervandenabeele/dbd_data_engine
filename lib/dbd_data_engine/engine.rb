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
end
