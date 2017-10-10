Rails.application.routes.draw do
  resources :users
  devise_for :users
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

  resources :classrooms do
        collection do
            post 'import'
        end
  end

  resources :categories
  resources :klasses, :path => 'classes' do
    collection do
        post 'import'
    end
  end
  resources :periods
  resources :materiels, :path => 'equipments'
  resources :dashboards
  resources :welcome
  resources :roles, :path => 'perfils'
  resources :sectors
  root 'welcome#index'
end
