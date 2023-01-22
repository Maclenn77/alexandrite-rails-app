Rails.application.routes.draw do
  get 'error_messages', to: 'error_messages#index'
  get 'error_messages/show'
  delete 'error_messages/delete'
  delete 'error_messages/delete_all'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'books#index', defaults: { format: :json }

  post 'books/bulk', defaults: { format: :json }

  get 'books/ddc', defaults: { format: :json }

  get 'books/show', defaults: { format: :json }

  post 'books/create', defaults: { format: :json }

  post 'books/delete', defaults: { format: :json }
end
