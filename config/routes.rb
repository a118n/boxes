Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#home'

  get 'about', to: 'static_pages#about'

  authenticate :user do
    get 'overview', to: 'static_pages#overview'
    get 'settings', to: 'static_pages#settings'
  end

end
