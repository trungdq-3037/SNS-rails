Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/' , to: 'hello_world#index'

  # namespace :admin do
  #   resources :articles, :comments
  # end
end
