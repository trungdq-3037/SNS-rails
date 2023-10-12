Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get '/' , to:  "hello_world#index"

  namespace :api do
    namespace :v1 do  
      get '/' , to:  "hello_world#index"
      post "/register", to: "user#create"
      post "/login", to: "authentication#create"

      resources :post
    end
  end
end
