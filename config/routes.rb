Rails.application.routes.draw do
  resources :tasks
resources :departments
resources :disciplines
resources :periods
resources :rooms
resources :categories
resources :student_classes, :path => 'classes'
resources :materiels, :path => 'equipments'
resources :dashboards
resources :welcome
root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
