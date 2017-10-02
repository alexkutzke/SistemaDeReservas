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
        csvFile = params[:file]
        
        error = false
        message = "Error to read csv file"

        begin
            CSV.foreach(csvFile.path, headers: true) do |row|
                if row['Subject'].nil?
                    raise Exception, "Incorrectly csv room file. Check the columns names"
                end
                @discipline = Discipline.new
                @array = row['Subject'].split(/-/)
                @discipline.discipline_code = @array[0]
                @discipline.name = @array[1]
                if params[:department_id].blank?
                    @discipline.department_id = nil
                else
                    @discipline.department_id = params[:department_id]
                end
                if !@array[0].nil? && !@array[1].nil?
                    puts "antes do save"
                    puts @discipline.save
                    puts "depois do save"
                    if !@discipline.save then 
                        puts "estou aqui"
                        error = true 
                    end
                    puts error
                end
            end
        rescue CSV::MalformedCSVError
            message = "Encolding error (use UTF-8)"
        rescue ActiveRecord::RecordInvalid => e
            if e.message == 'Validation failed: Name has already been taken'
                message = "Name has already been taken"
            end
        rescue Exception => e
            message = e.message
        end
        if error
            redirect_to new_discipline_path, :flash => { :error => message }
        else
            redirect_to disciplines_path
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
