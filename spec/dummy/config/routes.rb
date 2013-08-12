Rails.application.routes.draw do
  mount DbdDataEngine::Engine => '/'
end
