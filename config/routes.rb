Rails.application.routes.draw do
  resources :products do
    resources :warranties
  end
end
