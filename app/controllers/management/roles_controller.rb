class Management::RolesController < ApplicationController
  before_action :authenticate_user!, :set_session, :get_current_user, :get_permissions_from_user, :set_sessions_array, :authorize
  before_action :set_role, only: [:show, :edit, :destroy, :update]
  before_action :set_sessions_array, only: [:new, :edit, :create]

  # GET /perfils
  # GET /perfils.json
  def index
    @roles = Role.paginate(:page => params[:page], per_page: 30)
    @number = Role.count

    respond_to do |format|
        format.html
        format.json { render :json => Role.all }
    end
  end

  # POST /perfils/new
  def new
    @role = Role.new
    @sessions.each_with_index do |session,i|
        a = @role.permissions.build
        a.session = i
    end
  end

  # GET /perfils/1.json
  def show
    respond_to do |format|
        format.json { render json: @role }
    end
  end

  # GET /perfils/edit/1
  def edit
  end

  # POST /perfils
  # PODT /perfils.json
  def create
    @role = Role.new(role_params)

    # create a Array of action object from each line from table
    respond_to do |format|
        if @role.save
            @i = 0;
            @role.permissions = params[:role][:permission].values.map do |action_p|
              @p = Permission.new(action_p)
              if @p.new || @p.edit || @p.remove then @p.index = true end
              @p.session = @i
              @i = @i + 1
              @p
            end
            @role.save
            format.html { redirect_to management_roles_path }
            format.json { render json:  @role, status: :created }
        else
            format.html { render :new }
            format.json { render json: @role.errors, status: :unprocessable_entity }
        end
    end
  end

  # PATCH/PUT /perfils/1
  # PATCH/PUT /perfils/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        @role.permissions = params[:role][:permission].map do |key, value|
            index = value["index"] == "1" ? true : false
            index = true if value["new"] == "1" || value["edit"] == "1" || value["remove"] == "1"
            Permission.update(value["id"], :index =>  index, :new => value["new"], :edit => value["edit"], :remove => value["remove"], :import => value["import"])
        end
        format.html { redirect_to management_roles_path }
        format.json { render json: @role, status: :ok }
      else
        format.html { render :edit }
        format.json { render json:  @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perfils/1
  # DELETE /perfils/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to management_roles_url, notice: 'Perfil was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    # case actions_attributes: set on permit, has a error "Actions required"
    # case actions parameter, then rails console show "Unpermitted parameter: actions_attributes"
    # https://stackoverflow.com/questions/32529757/how-can-i-get-strong-parameters-to-permit-nested-fields-for-attributes
    params.require(:role).permit(:name)#, actions: [:view, :register, :edit, :remove])
  end

  def role_and_actions_params
    params.require(:role).permit(:permission_attributes => [:id, :index, :new, :edit, :remove])
  end

  def set_sessions_array
    @sessions = [
      {
        :name => "Reservas",
        :permissions => [:index, :new, :edit,:remove, :import]
      },
      {
        :name => "Solicitações",
        :permissions => [:index, :new, :edit,:remove]
      },
      {
        :name => "Perfis",
        :permissions => [:index, :new, :edit,:remove]
      },
      {
        :name => "Usuários",
        :permissions => [:index, :new, :edit,:remove, :import]
      },
      {
        :name => "Setores",
        :permissions => [:index, :new, :edit,:remove]
      },
      {
        :name => "Departamentos",
        :permissions => [:index, :new, :edit,:remove]
      },
      {
        :name => "Categorias",
        :permissions => [:index, :new, :edit,:remove]
      },
      {
        :name => "Salas",
        :permissions => [:index, :new, :edit,:remove, :import]
      },
      {
        :name => "Disciplinas",
        :permissions => [:index, :new, :edit,:remove, :import]
      },
      {
        :name => "Turmas",
        :permissions => [:index, :new, :edit,:remove, :import]
      },
      {
        :name => "Equipamentos",
        :permissions => [:index, :new, :edit,:remove]
      },
      {
        :name => "Períodos",
        :permissions => [:index, :new, :edit,:remove]
      }
    ]
  end

  def set_session
    @session = 6
  end
end
