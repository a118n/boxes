Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'

  devise_for :users, controllers: { registrations: 'registrations' }

  root 'static_pages#home'

  get 'about', to: 'static_pages#about'

  authenticate :user do
    get 'overview', to: 'static_pages#overview'
    get 'search', to: 'static_pages#search'

    resource :settings, only: [:edit, :update]

    resources :sites do

      resources :devices do
        member { get :assign }
        resources :repairs
      end

      resources :supplies do
        member { get :assign, :history, :use }
      end
    end

    get 'all_devices', to: 'devices#all'
    get 'export_devices', to: 'devices#export'
    get 'all_supplies', to: 'supplies#all'
    get 'export_supplies', to: 'supplies#export'

  end

  authenticate :user, lambda { |u| u.has_role? :admin } do
    mount Sidekiq::Web => '/sidekiq'
    resources :users_admin, controller: 'users'
  end

end
