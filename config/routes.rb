Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#home'

  get 'about', to: 'static_pages#about'

  authenticate :user do
    get 'overview', to: 'static_pages#overview'
    get 'settings', to: 'static_pages#settings'

    resources :sites do

      resources :devices do
        member { get :assign }
      end

      resources :supplies do
        member { get :assign }
      end
    end

    get 'all_devices', to: 'devices#all'
    get 'export_devices', to: 'devices#export'
    get 'all_supplies', to: 'supplies#all'
    get 'export_supplies', to: 'supplies#export'

  end
end