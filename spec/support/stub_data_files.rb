def stub_data_files
  DbdDataEngine.stub(:default_data_dir).and_return(
    "#{File.dirname(__FILE__)}/../dummy/data/real_data"
  )
end
