class PerfilsController < ApplicationController
    before_action :set_perfil, only: [:show, :edit, :destroy, :update]

    # GET /perfils
    # GET /perfils.json
    def index
        @perfils = Perfil.paginate(:page => params[:page], per_page:5)
        @number = Perfil.count

        respond_to do |format|
            format.html
            format.json { render :json => Perfil.all }
        end
    end

    # POST /perfils/new
    def new
        @perfil = Perfil.new
        @sessions = Array.new(["Reservas", "Solicitações",  "Perfis", "Usuários", "Departamentos", "Categorias", "Salas", "Disciplinas", "Turmas", "Equipamentos", "Períodos"])
        @sessions.each_with_index do |session,i|
            a = @perfil.actions.build
            a.session = i
        end
    end

    # GET /perfils/1.json
    def show
        respond_to do |format|
            format.json { render json: @perfil }
        end
    end

    # GET /perfils/edit/1
    def edit
        @sessions = Array.new(["Reservas", "Solicitações",  "Perfis", "Usuários", "Departamentos", "Categorias", "Salas", "Disciplinas", "Turmas", "Equipamentos", "Períodos"])
    end

    # POST /perfils
    # PODT /perfils.json
    def create
        @perfil = Perfil.new(perfil_params)

        # create a Array of action object from each line from table
        respond_to do |format|
            if @perfil.save
                @perfil.actions = params[:perfil][:action].values.map {|action_p| Action.create(action_p)}
                @perfil.save
                format.html { redirect_to perfils_path }
                format.json { render json:  @perfil, status: :created }
            else
                @sessions = Array.new(["Reservas", "Solicitações",  "Perfis", "Usuários", "Departamentos", "Categorias", "Salas", "Disciplinas", "Turmas", "Equipamentos", "Períodos"])
                format.html { render :new }
                format.json { render json: @perfil.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /perfils/1
    # PATCH/PUT /perfils/1.json
    def update
        respond_to do |format|
            if @perfil.update(perfil_params)
                params[:perfil][:action].each_with_index do |a, i|
                    @perfil.actions = a;
                    @perfil.actions.update(actions_params(i))
                end
                # @perfil.actions.each do |action_p| 
                #     Action.find(action_p["id"]).update(actions_params)
                # end
                # @perfil.actions = params[:perfil][:action].values.map { |action_p| Action.find(action_p["id"]).update(actions_params)}
                #     @a = Action.find(action_p["id"])
                #     puts @a.id
                #     puts @a.view
                #     # puts @perfil.actions.id
                #     if !@a.nil?
                #         @a.update()
                #     end
                #     # segundo o Action.find(action_p["id"]) ---- Action.find_or_create 
                # end
                format.html { redirect_to perfils_path }
                format.json { render json: @perfil, status: :ok }
            else
                format.html { render :edit }
                format.json { render json:  @perfil.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /perfils/1
    # DELETE /perfils/1.json
    def destroy
        @perfil.destroy
        respond_to do |format|
            format.html { redirect_to perfils_url, notice: 'Perfil was successfully removed.' }
            format.json { head :no_content }
        end
    end

    private
    def set_perfil
        @perfil = Perfil.find(params[:id])
    end

    def perfil_params
        # case actions_attributes: set on permit, has a error "Actions required"
        # case actions parameter, then rails console show "Unpermitted parameter: actions_attributes"
        # https://stackoverflow.com/questions/32529757/how-can-i-get-strong-parameters-to-permit-nested-fields-for-attributes
        params.require(:perfil).permit(:name)#, actions: [:view, :register, :edit, :remove])
    end

    def actions_params (i)
        params.require(:perfil).permit(:action[i][:view, :register, :edit, :remove])
    end
end
