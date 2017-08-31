Rails.application.routes.draw do
  resources :products do
    resources :warranties
  end

  post 'auth/login', to: 'authentication#authenticate'
end
