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
    end

    # GET /perfils/1.json
    def show
        respond_to do |format|
            format.json { render json: @perfil }
        end
    end

    # GET /perfils/edit/1
    def edit
    end

    # POST /perfils
    # PODT /perfils.json
    def create
        @perfil = Perfil.new(perfil_params)
        # create a Array of action object from each line from table
        respond_to do |format|
            if @perfil.save
                format.html { redirect_to perfils_path }
                format.json { render json:  @perfil, status: :created }
            else
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
        params.require(:perfil).permit(:name, action: [:view, :register, :edit, :remove])
    end

    def actions_params
        params.permit(actions_attributes: [:view, :register, :edit, :remove])
    end
end
