DbdDataEngine::Engine.routes.draw do
  resource 'data', only: [:new, :create]
  get 'data/' => 'data#index', as: :data_index
  get 'data/:id' => 'data#show', as: :data_show
end
