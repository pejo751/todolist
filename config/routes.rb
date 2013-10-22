Todolist::Application.routes.draw do

  root 'home#index'

  resources :projects do
    resources :tasks
  end
end
