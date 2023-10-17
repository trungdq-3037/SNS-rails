Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get '/' , to:  "hello_world#index"

  namespace :api do
    namespace :v1 do
      get '/', to: 'hello_world#index'
      post '/register', to: 'user#create'
      post '/login', to: 'authentication#create'
      get '/user/current', to: 'user#show'

      resources :post, only: [:update, :destroy, :create, :index]
      resources :comment, only: [:update, :destroy, :create]
      scope :like do
        post '/:post_id', to: 'like#create'
        delete '/:post_id', to: 'like#destroy'
      end
    end
  end
end
