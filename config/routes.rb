Rails.application.routes.draw do
  root 'home#index'
  
  get "up" => "rails/health#show", as: :rails_health_check

  resources :proponents, only: [:new, :create, :show]

  get 'inss_discount', to: 'inss#calculate'

end
