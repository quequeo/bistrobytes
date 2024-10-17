Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get "imports/create"

      resources :restaurants do
        resources :menus do
          resources :menu_items, only: [:index, :create]
        end
      end
      
      resources :menu_items, only: [:show, :update, :destroy]

      post 'imports', to: 'imports#create'
    end
  end
end