Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :worlds do
    resources :chunks do
      member do
        post :randomize
        get :set_tile
      end
    end
  end

  root 'worlds#index'
end
