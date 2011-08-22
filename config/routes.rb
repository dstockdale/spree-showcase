Rails.application.routes.draw do
  namespace :admin do
    resources :products do
      resources :showcases
    end
  end
end