Rails.application.routes.draw do
  get 'home/index'
  
  get "up" => "rails/health#show", as: :rails_health_check

  resources :proponents, only: [:new, :create, :show]

end
