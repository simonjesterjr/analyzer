Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :portfolios do
    member do
      get "historical_test"
    end
  end

end
