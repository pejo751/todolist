Todolist::Application.routes.draw do

  resources :companies

  devise_for :users
  devise_scope :user do
    get "signup", :to => "devise/registrations#new"
  end
  root to: 'home#index'

  resources :projects do
    resources :tasks do
      resources :stages, only: :update
    end
  end

  put "/projects/:project_id/tasks/:task_id/stages/:id" => "stages#update",
    as: :stage_change

end
