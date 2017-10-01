Rails.application.routes.draw do
resources :departments do
    collection do
        post 'import'
    end
end

resources :disciplines do
    collection do
        post 'import'
    end
end

resources :periods

resources :classrooms do
    collection do
        post 'import'
    end
end

resources :categories
resources :klasses, :path => 'classes'
resources :materiels, :path => 'equipments'
resources :dashboards
resources :welcome
resources :roles, :path => 'perfils'
resources :sectors
root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
