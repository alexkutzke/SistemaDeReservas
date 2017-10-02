class DisciplinesController < ApplicationController
    require 'csv'
    before_action :set_discipline, only: [:update, :destroy, :edit, :show]

    # GET /disciplines
    # GET /disciplines.json
    def index
        @disciplines = Discipline.paginate(:page => params[:page], per_page:5)
        @number = Discipline.count

        respond_to do |format|
            format.html
            format.json { render :json => Discipline.all.to_json(include: :department) }
        end
    end

    # GET /disciplines/1.json
    def show
        respond_to do |format|
            format.json { render :json => @discipline.to_json(include: :department) }
        end
    end

    # POST /disciplines/new
    def new
        @discipline = Discipline.new
    end

    # GET /disciplines/edit/1
    def edit
    end

    # POST /disciplines
    # POST /disciplines.json
    def create
        @discipline = Discipline.new(discipline_params)
        respond_to do |format|
            if @discipline.save
                format.html { redirect_to disciplines_path }
                format.json { render :json => @discipline.to_json(include: :department), status: :created }
            else
                format.html { render :new }
                format.json { render json: @discipline.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /disciplines/1
    # PATCH/PUT /disciplines/1.json
    def update
        respond_to do |format|
            if @discipline.update(discipline_params)
                format.html { redirect_to disciplines_path }
                format.json { render :json => @discipline.to_json(include: :department), status: :created }             
            else
                format.html { render :edit }
                format.json { render json: @discipline.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /disciplines/1
    # DELETE /disciplines/1.json
    def destroy
        @discipline.destroy
        respond_to do |format|
            format.html { redirect_to disciplines_path, notice: 'Discipline was successfully removed.' }
            format.json { head :no_content }
        end
    end

    def import
        # pegar total de registros e fazer um progress bar
        Discipline.import(params[:file])
    end

    private
    def set_discipline
        @discipline = Discipline.find(params[:id])
    end
    def discipline_params
        params.require(:discipline).permit(:name, :discipline_code, :department_id)
    end
end
