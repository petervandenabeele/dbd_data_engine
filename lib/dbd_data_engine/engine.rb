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

  def self.default_data_dir
    'data/real_data'
  end

  def self.default_CSV_location
    "#{default_data_dir}/graph.csv"
  end
end
