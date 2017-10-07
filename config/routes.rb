Rails.application.routes.draw do
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get "/sign_up" => "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
  end
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

  resources :users
  resources :periods
  resources :materiels, :path => 'equipments'
  resources :dashboards
  resources :welcome
  resources :roles, :path => 'perfils'
  resources :sectors
  root 'welcome#index'
end
