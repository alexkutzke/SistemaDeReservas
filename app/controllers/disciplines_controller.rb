class DisciplinesController < ApplicationController
    before_action :set_discipline, only: [:update, :destroy, :edit, :show]

    # GET /disciplines
    # GET /disciplines.json
    def index
        @disciplines = Discipline.paginate(:page => params[:page], per_page:5)
        @number = Discipline.number_of_records

        respond_to do |format|
            format.html
            format.json { render :json => {:discipline => Discipline.all, :department => Department.all} }
        end
    end

    # GET /disciplines/1.json
    def show
        respond_to do |format|
            format.json { render json: @discipline }
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
                @department = @discipline.department
                format.html { redirect_to disciplines_path }
                format.json { render :json => { :discipline => @discipline, :department => @department }, status: :created }
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
                format.json { render :json => { :discipline => @discipline, :department => @department }, status: :created }             
            else
                format.html { render :edit }
                format.json { render json: @discipline.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @discipline.destroy
        respond_to do |format|
            format.html { redirect_to disciplines_path, notice: 'Task was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    def set_discipline
        @discipline = Discipline.find(params[:id])
    end
    def discipline_params
        params.require(:discipline).permit(:name, :discipline_code, :department_id)
    end
end
