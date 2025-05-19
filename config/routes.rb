Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  get "up" => "rails/health#show", as: :rails_health_check

  resources :proponents

  get 'inss_discount', to: 'inss#calculate'

end
