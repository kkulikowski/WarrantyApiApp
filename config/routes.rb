Rails.application.routes.draw do
  resources :products do
    resources :warranties
  end

  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'
end
