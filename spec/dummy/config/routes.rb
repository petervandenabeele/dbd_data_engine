Rails.application.routes.draw do

  mount DbdDataEngine::Engine => "/dbd_data_engine"
end
