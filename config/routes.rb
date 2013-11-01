Todolist::Application.routes.draw do
  devise_for :users

  devise_scope :user do
    get    "signup",  to: "devise/registrations#new"
    get    "signin",  to: "devise/sessions#new"
    delete "signout", to: "devise/sessions#destroy"
  end

  resources :projects do
    resources :tasks do
      resources :stages, only: :update
    end
  end

  put "/projects/:project_id/tasks/:task_id/stages/:id" => "stages#update",
    as: :stage_change

  root to: 'home#index'
end
