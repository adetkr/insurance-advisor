Rails.application.routes.draw do
  root to: "pages#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :contacts, only: [:create]
  resources :simulations, only: [:create, :show, :update]

  namespace :simulation do
    resource :profile, path: 'vos-informations', only: %i[show]
    resources :contacts, only: [] do
      resource :need, path: 'votre-besoin', only: %i[show, edit]
    end
  end
end
