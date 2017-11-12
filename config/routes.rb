Rails.application.routes.draw do
  resources :events
  namespace :management, :path => 'acesso' do
    scope(:path_names => { :new => "cadastrar", :edit => "editar" }) do
      resources :departments, :path => 'departamentos'
    end
    scope(:path_names => { :new => "cadastrar", :edit => "editar" }) do
      resources :users, :path => "usuarios"
    end
    resources :solicitations, :path => 'solicitacoes'  do
      collection do
        put 'approve', :path => 'aprovar/:id'
        put 'refuse', :path => 'recusar/:id'
        put 'cancel', :path => 'cancelar/:id'
      end
    end
    resources :schedules, :path => 'reservas'
    scope(:path_names => { :new => "cadastrar", :edit => "editar" }) do
      resources :disciplines, :path => "disciplinas" do
        collection do
          post 'import', :path => 'importar'
        end
      end
    end
    scope(:path_names => { :new => "cadastrar", :edit => "editar" }) do
      resources :classrooms, :path => "salas" do
        collection do
          post 'import', :path => 'importar'
        end
      end
    end
    scope(:path_names => { :new => "cadastrar", :edit => "editar" }) do
      resources :categories, :path => "categorias"
    end
    scope(:path_names => { :new => "cadastrar", :edit => "editar" }) do
      resources :klasses, :path => "turmas" do
        collection do
            post 'import', :path => 'importar'
        end
      end
    end
    scope(:path_names => { :new => "cadastrar", :edit => "editar" }) do
      resources :periods, :path => "periodos"
    end
    scope(:path_names => { :new => "cadastrar", :edit => "editar" }) do
      resources :materiels, :path => "equipamentos"
    end
    resources :dashboards
    scope(:path_names => { :new => "cadastrar", :edit => "editar" }) do
      resources :roles, :path => "perfils"
    end
    scope(:path_names => { :new => "cadastrar", :edit => "editar" }) do
      resources :sectors, :path => "setores"
    end
  end
  resources :schedules, :path => "reservas"
  resources :welcome
  devise_for :users, :path => "usuarios"
  authenticated :user do
    root :to => redirect('acesso/reservas')
  end
  root 'welcome#index'
end
