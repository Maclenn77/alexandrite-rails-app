Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "books#create", defaults: { format: :json }

  post 'books/bulk', defaults: { format: :json }
end
