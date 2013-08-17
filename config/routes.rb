DbdDataEngine::Engine.routes.draw do
  resources 'data', only: [:index]
  scope 'data' do
    resources 'resources', only: [:index, :new, :create]
  end
end
