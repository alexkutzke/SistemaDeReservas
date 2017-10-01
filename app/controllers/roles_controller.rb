class RolesController < ApplicationController
    before_action :set_role, only: [:show, :edit, :destroy, :update]

    # GET /perfils
    # GET /perfils.json
    def index
        @roles = Role.paginate(:page => params[:page], per_page:5)
        @number = Role.count

        respond_to do |format|
            format.html
            format.json { render :json => Role.all }
        end
    end

    # POST /perfils/new
    def new
        @role = Role.new
        @sessions = Array.new(["Reservas", "Solicitações",  "Perfis", "Usuários", "Departamentos", "Categorias", "Salas", "Disciplinas", "Turmas", "Equipamentos", "Períodos"])
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
        @sessions = Array.new(["Reservas", "Solicitações",  "Perfis", "Usuários", "Departamentos", "Categorias", "Salas", "Disciplinas", "Turmas", "Equipamentos", "Períodos"])
    end

    # POST /perfils
    # PODT /perfils.json
    def create
        @role = Role.new(role_params)

        # create a Array of action object from each line from table
        respond_to do |format|
            if @role.save
                @role.permissions = params[:role][:permission].values.map {|action_p| Permission.create(action_p)}
                @role.save
                format.html { redirect_to roles_path }
                format.json { render json:  @role, status: :created }
            else
                @sessions = Array.new(["Reservas", "Solicitações",  "Perfis", "Usuários", "Departamentos", "Categorias", "Salas", "Disciplinas", "Turmas", "Equipamentos", "Períodos"])
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
                    Permission.update(value["id"], :view =>  value["view"], :register => value["register"], :edit => value["edit"], :remove => value["remove"]) 
                end
                format.html { redirect_to roles_path }
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
            format.html { redirect_to roles_url, notice: 'Perfil was successfully removed.' }
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
        params.require(:role).permit(:permission_attributes => [:id, :view, :register, :edit, :remove])
    end
end
